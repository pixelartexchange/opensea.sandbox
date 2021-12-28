require 'pp'
require 'time'
require 'date'

require 'uri'
require 'net/http'
require 'net/https'
require 'cgi'
require 'fileutils'         ### used ??? remove??

require 'json'


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


def copy_image( src, dest )
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





######################
#  pixelart image extensions
#    move upstream!!!!!


module Pixelart

class Image
  def crop( x, y, crop_width, crop_height )
    self.class.new(  nil, nil,
                     self.image.crop( x,y, crop_width, crop_height ) )
  end


  def sample( offsets )
    ## note: for now always assume square image (e.g. 24x24, 32x32 and such)
    width = height = offsets.size

    puts "     #{self.width}x#{self.height} => #{width}x#{height}"


    dest = Image.new( width, height )

    offsets.each do |offset_x, x|
      offsets.each do |offset_y, y|
         pixel = self[offset_x,offset_y]

         dest[x,y] =  pixel
      end
    end

    dest
  end
  alias_method :pixelate, :sample


  def transparent( style = :solid, fuzzy: false )
    img = Image.new( width, height )


    background = self[0,0]

    bh,bs,bl =  Color.to_hsl( background )
    bh = (bh % 360)  ## might might negative degree (always make positive)

    height.times do |y|
        if style == :linear
          background = self[0,y]

          bh,bs,bl =  Color.to_hsl( background )
          bh = (bh % 360)  ## might might negative degree (always make positive)
        end
      width.times do |x|
        pixel = self[x,y]

        if background == 0  ## special case if background is already transparent keep going
          img[x,y] =  pixel
        elsif fuzzy
          ## check for more transparents
            ##   not s  is 0.0 to 0.99  (100%)
            ##   and l  is 0.0 to 0.99  (100%)
          h,s,l =  Color.to_hsl( pixel )
          h = (h % 360)  ## might might negative degree (always make positive)

          ## try some kind-of fuzzy "heuristic" match on background color
          if ((h >= bh-5) && (h <= bh+5)) &&
             ((s >= bs-0.07) && (s <= bs+0.07)) &&
             ((l >= bl-0.07) && (l <= bl+0.07))
           img[x,y] = 0  ## Color::TRANSPARENT

           if h != bh || s != bs || l != bl
              # report fuzzy background color
              puts "  #{x}/#{y} fuzzy background #{[h,s,l]} ~= #{[bh,bs,bl]}"
           end
          else
            img[x,y] =  pixel
          end
        else
           if pixel == background
            img[x,y] = 0   ## Color::TRANSPARENT
           else
             img[x,y] =  pixel
           end
        end
      end
    end
    img
  end # method transparent
end  # class Image



class ImageComposite


def add_glob( glob )
  files = Dir.glob( glob )
  puts "#{files.size} file(s) found matching >#{glob}<"


  files = files.sort
  ## puts files.inspect

  files.each_with_index do |file,i|
     puts "==> [#{i+1}/#{files.size}] - #{file}"
     img = Image.read( file )

     self << img    ## todo/check: use add alias - why? why not?
  end
end

end   # class ImageComposite
end   # module Pixelart





###################################
#  try a new Collection full-service class


#############
# read meta data into struct

class Meta
  def self.read( path )
    txt  = File.open( path, 'r:utf-8' ) { |f| f.read }
    data = JSON.parse( txt )
    new( data )
  end


  def initialize( data )
    @data = data

    assets = @data['assets']
    if assets.size != 1
      puts "!! error - expected one asset per file only - got #{assets.size} - sorry"
      exit 1
    end

    @asset = assets[0]
  end

  def name
    @name ||= _normalize( @asset['name'] )
  end

  def description
    @description ||= _normalize( @asset['description'] )
  end

  def image_original_url() @asset['image_original_url']; end
  def image_url()          @asset['image_url']; end

  def token_id() @asset['token_id']; end    ## note: keep id as string as is - why? why not?


  def traits
    @traits ||= begin
                   traits = {}
                   @asset[ 'traits' ].each do |t|
                      trait_type = t['trait_type'].strip
                      h = {}
                      # todo/fix:  change to a different model with multiple values!!!
                      #if traits.has_key?( trait_type )
                      #  puts "!! error - duplicate trait type >#{trait_type}< not allowed for now, sorry"
                      #  pp @assets['traits']
                      #  puts "---"
                      #  pp @data
                      #  exit 1
                      #end
                      ## add all key/value pairs (except trait_type)
                      t.each do |k,v|
                         next if k == 'trait_type'
                         h[k] = v
                      end
                      traits[ trait_type] = h
                   end

                   traits
                  end
    end



### "private"  convenience / helper methods
    def _normalize( str )
       ## normalize string
       ##   remove leading and trailing spaces
       ##   collapse two and more spaces into one
       ##    change unicode space to ascii
       str = str.gsub( "\u{00a0}", ' ' )
       str = str.strip.gsub( /[ ]{2,}/, ' ' )
       str
    end
end  # class Meta





class Collection

attr_reader :slug, :count

def initialize( slug, count )   # check: rename count to items or such - why? why not?
  @slug = slug
  @count = count
end


def download_meta( range=(0...@count) )
  self.class.download_meta( range, @slug )
end

def download_images( range=(0...@count) )
  self.class.download_images( range, @slug )
end

def download( range=(0...@count) )
  download_meta( range )
  download_images( range )
end



################################
# private (static) helpers
#

BASE = 'https://api.opensea.io/api/v1/assets?collection={collection}&order_direction=asc&offset={offset}&limit=1'



def self.download_images( range, collection,
                            original: false )
  start = Time.now
  delay_in_s = 0.3

  range.each do |offset|
    meta = Meta.read( "./#{collection}/meta/#{offset}.json" )

    puts "==> #{offset}.json  -  #{meta.name}"

    image_src =  if original
                   meta.image_original_url
                 else
                   meta.image_url
                 end

    puts "    >#{image_src}<"
    if image_src.nil?
       puts "!! ERROR - no image url found (use original: #{original}):"
       pp asset
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

    puts "sleeping #{delay_in_s}s..."
    sleep( delay_in_s )

    stop = Time.now
    diff = stop - start

    mins = diff / 60  ## todo - use floor or such?
    secs = diff % 60
    puts "up #{mins} mins #{secs} secs (total #{diff} secs)"
  end
end


def self.download_meta( range, collection )
  start = Time.now
  delay_in_s = 0.3

  range.each do |offset|

    src = BASE.sub( '{collection}', collection ).
               sub( '{offset}', offset.to_s )

    dest = "./#{collection}/meta/#{offset}.json"

    puts "==> #{offset} - GET #{src}..."
    copy_json( src, dest )

    puts "  sleeping #{delay_in_s}s..."
    sleep( delay_in_s )

    stop = Time.now
    diff = stop - start

    mins = diff / 60  ## todo - use floor or such?
    secs = diff % 60
    puts "up #{mins} mins #{secs} secs (total #{diff} secs)"
  end
end
end # class Collection


