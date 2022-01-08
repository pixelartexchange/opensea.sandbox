require 'pp'
require 'time'
require 'date'

require 'uri'
require 'net/http'
require 'net/https'
require 'cgi'
require 'fileutils'         ### used ??? remove??

require 'json'

require 'optparse'




$LOAD_PATH.unshift( "../pixelart/pixelart/lib" )
## our own gems
require 'pixelart'



def slugify( name )
  name.downcase.gsub( /[^a-z0-9 ()$_-]/ ) do |_|
     puts " !! WARN: asciify - found (and removing) non-ascii char >#{Regexp.last_match}<"
     ''  ## remove - use empty string
  end.gsub( ' ', '_')
end




def convert_images( collection, from: 'jpg',
                                to: 'png' )
    files = Dir.glob( "./#{collection}/i/*.#{from}" )
    puts "==> converting #{files.size} image(s) from #{from} to #{to}"

    files.each_with_index do |file,i|
      dirname   = File.dirname( file )
      extname   = File.extname( file )
      basename  = File.basename( file, extname )

      cmd = "magick convert #{dirname}/#{basename}.#{from} #{dirname}/#{basename}.#{to}"

      puts "   [#{i+1}/#{files.size}] - #{cmd}"
      system( cmd )
    end
end








def copy_json( src, dest )
  uri = URI.parse( src )

  http = Net::HTTP.new( uri.host, uri.port )

  puts "[debug] GET #{uri.request_uri} uri=#{uri}"

  headers = { 'User-Agent' => "ruby v#{RUBY_VERSION}" }


  request = Net::HTTP::Get.new( uri.request_uri, headers )
  if uri.instance_of? URI::HTTPS
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  response   = http.request( request )

  if response.code == '200'
    puts "#{response.code} #{response.message}"
    puts "  content_type: #{response.content_type}, content_length: #{response.content_length}"

    text = response.body.to_s
    text = text.force_encoding( Encoding::UTF_8 )

    data = JSON.parse( text )

    File.open( dest, "w:utf-8" ) do |f|
      f.write( JSON.pretty_generate( data ) )
    end
  else
    puts "!! error:"
    puts "#{response.code} #{response.message}"
    exit 1
  end
end


def copy_image( src, dest,
                 dump_headers: false )
  uri = URI.parse( src )

  http = Net::HTTP.new( uri.host, uri.port )

  puts "[debug] GET #{uri.request_uri} uri=#{uri}"

  headers = { 'User-Agent' => "ruby v#{RUBY_VERSION}" }

  request = Net::HTTP::Get.new( uri.request_uri, headers )
  if uri.instance_of? URI::HTTPS
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  response   = http.request( request )

  if response.code == '200'
    puts "#{response.code} #{response.message}"

    content_type   = response.content_type
    content_length = response.content_length
    puts "  content_type: #{content_type}, content_length: #{content_length}"

    if dump_headers   ## for debugging dump headers
      headers = response.each_header.to_h
      puts "htttp respone headers:"
      pp headers
    end


    format = if content_type =~ %r{image/jpeg}i
                'jpg'
             elsif content_type =~ %r{image/png}i
                'png'
              elsif content_type =~ %r{image/gif}i
                'gif'
             else
              puts "!! error:"
              puts " unknown image format content type: >#{content_type}<"
              exit 1
            end

    ## todo/fix/add:
    ##   make sure path exits - autocreate dirs

    File.open( "#{dest}.#{format}", 'wb' ) do |f|
      f.write( response.body )
    end
  else
    puts "!! error:"
    puts "#{response.code} #{response.message}"
    exit 1
  end
end





require_relative 'helper_image'
require_relative 'helper_opensea'




###################################
#  try a new Collection full-service class




class TokenCollection

  attr_reader :slug, :count

  def initialize( slug, count,
                  token_base: )   # check: rename count to items or such - why? why not?
    @slug = slug
    @count = count
    @token_base = token_base
  end

  def download_meta( range=(0...@count) )
    start = Time.now
    delay_in_s = 0.3

    range.each do |offset|
      token_src = @token_base.sub( '{id}', offset.to_s )

      puts "==> #{offset} - #{@slug}..."

      copy_json( token_src, "./#{@slug}/token-meta/#{offset}.json" )

      stop = Time.now
      diff = stop - start

      mins = diff / 60  ## todo - use floor or such?
      secs = diff % 60
      puts "up #{mins} mins #{secs} secs (total #{diff} secs)"

      puts "sleeping #{delay_in_s}s..."
      sleep( delay_in_s )
    end
  end

  def download_images( range=(0...@count) )
    start = Time.now
    delay_in_s = 0.3

    range.each do |offset|
      txt = File.open( "./#{@slug}/token-meta/#{offset}.json", 'r:utf-8') { |f| f.read }
      data = JSON.parse( txt )

      meta_name  = data['name']
      meta_image = data['image']

      puts "==> #{offset} - #{@slug}..."
      puts "   name: #{meta_name}"
      puts "   image: #{meta_image}"

      ## note: will auto-add format file extension (e.g. .png, .jpg)
      ##        depending on http content type!!!!!
      start_copy = Time.now
      copy_image( meta_image, "./#{@slug}/token-i/#{offset}" )

      stop = Time.now

      diff = stop -start_copy
      puts "    download image in #{diff} sec(s)"

      diff = stop - start
      mins = diff / 60  ## todo - use floor or such?
      secs = diff % 60
      puts "up #{mins} mins #{secs} secs (total #{diff} secs)"

      puts "sleeping #{delay_in_s}s..."
      sleep( delay_in_s )
    end
  end
end # class TokenCollection



class ImageCollection

  attr_reader :slug, :count

  def initialize( slug, count,
                  image_base: )   # check: rename count to items or such - why? why not?
    @slug = slug
    @count = count
    @image_base = image_base
  end

  def download_images( range=(0...@count) )
    start = Time.now
    delay_in_s = 0.3

    range.each do |offset|
      image_src = @image_base.sub( '{id}', offset.to_s )

      puts "==> #{offset} - #{@slug}..."

      ## note: will auto-add format file extension (e.g. .png, .jpg)
      ##        depending on http content type!!!!!
      copy_image( image_src, "./#{@slug}/image-i/#{offset}" )

      stop = Time.now
      diff = stop - start

      mins = diff / 60  ## todo - use floor or such?
      secs = diff % 60
      puts "up #{mins} mins #{secs} secs (total #{diff} secs)"

      puts "sleeping #{delay_in_s}s..."
      sleep( delay_in_s )
    end
  end
end # class ImageCollection




class Collection

attr_reader :slug, :count

def initialize( slug, count,
                meta_slugify: nil,
                image_pixelate: nil )   # check: rename count to items or such - why? why not?
  @slug = slug
  @count = count

  @meta_slugify   = meta_slugify
  @image_pixelate = image_pixelate
end


def download_meta( range=(0...@count), mode: nil )
  self.class.download_meta( range, @slug, mode: mode )
end

def download_images( range=(0...@count) )
  self.class.download_images( range, @slug )
end

def download( range=(0...@count) )
  download_meta( range )
  download_images( range )
end


def pixelate( range=(0...@count) )
  range.each do |id|

    meta = OpenSea::Meta.read( "./#{@slug}/meta/#{id}.json" )

    puts meta.name

    meta_slug = @meta_slugify.call( meta, id )

    img = Image.read( "./#{@slug}/i/#{id}.png" )

    pix = @image_pixelate.call( img )

    path = "./#{@slug}/ii/#{meta_slug}.png"
    puts "   saving to >#{path}<..."
    pix.save( path )
  end
end


################################
# private (static) helpers
#

def self.download_images( range, collection,
                            original: false )
  start = Time.now
  delay_in_s = 0.3

  range.each do |offset|
    meta = OpenSea::Meta.read( "./#{collection}/meta/#{offset}.json" )

    puts "==> #{offset}.json  -  #{meta.name}"

    image_src =  if original
                   meta.image_original_url
                 else
                   meta.image_url
                 end

    puts "    >#{image_src}<"
    if image_src.nil?
       puts "!! ERROR - no image url found (use original: #{original}):"
       pp meta
       exit 1
    end

    ## note: use a different directory to avoid size confusion!!!
    img_slug =  if original
                   'i_org'
                else
                   'i'
                end

    ## note: will auto-add format file extension (e.g. .png, .jpg)
    ##        depending on http content type!!!!!
    copy_image( image_src, "./#{collection}/#{img_slug}/#{offset}" )

    stop = Time.now
    diff = stop - start

    mins = diff / 60  ## todo - use floor or such?
    secs = diff % 60
    puts "up #{mins} mins #{secs} secs (total #{diff} secs)"

    puts "sleeping #{delay_in_s}s..."
    sleep( delay_in_s )
  end
end


def self.download_meta( range, collection, mode: nil )
  start = Time.now
  delay_in_s = 0.3

  fixme = mode && ['fix', 'repair'].include?( mode.to_s.downcase )


  range.each do |offset|

    dest = "./#{collection}/meta/#{offset}.json"
    meta = nil

    ## check for auto-fix / repair mode
    if fixme && File.exist?( dest )
      meta = OpenSea::Meta.read( dest )
      if meta.image_url
        ##  meta data with image_url; everything OK; continue/next
        print "#{offset} "
        next
      end

      puts "  retry to fix / repair"
      ## todo/check:  check if id/token_id match/before and after - why? why not?
    end

    puts "==> #{offset} / #{collection} (#{dest})..."

    data = OpenSea.assets( collection: collection,
                           offset:     offset )
    meta = OpenSea::Meta.new( data )
    puts "  name:      >#{meta.name}<"
    puts "  image_url: >#{meta.image_url}<"


    File.open( dest, "w:utf-8" ) do |f|
      f.write( JSON.pretty_generate( data ) )
    end


    stop = Time.now
    diff = stop - start

    mins = diff / 60  ## todo - use floor or such?
    secs = diff % 60
    puts "up #{mins} mins #{secs} secs (total #{diff} secs)"

    puts "  sleeping #{delay_in_s}s..."
    sleep( delay_in_s )
  end
end


end # class Collection



require_relative 'helper_attributes'
require_relative 'helper_tool'


