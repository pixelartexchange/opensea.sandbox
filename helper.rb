require 'pp'
require 'time'
require 'date'

require 'uri'
require 'net/http'
require 'net/https'
require 'cgi'
require 'fileutils'         ### used ??? remove??

require 'json'


def slugify( name )
  name.downcase.gsub( /[^a-z0-9 ()$-]/ ) do |_|
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




BASE = "https://api.opensea.io/api/v1/assets?collection={collection}&order_direction=asc&offset={offset}&limit=1"


def download_images( range, collection,
                        original: false )
  start = Time.now
  delay_in_s = 0.3

  range.each do |offset|
    txt = File.open( "./#{collection}/meta/#{offset}.json", "r:utf-8") { |f| f.read }
    data = JSON.parse( txt )

    assets = data['assets']
    if assets.size != 1
       puts "!! error - expection one asset per file"
       exit 1
    end

    asset = assets[0]

    puts "==> #{offset}.json  -  #{asset['name']}"

    image_src =  if original
                   asset['image_original_url']
                 else
                   asset['image_url']
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


def download_meta( range, collection )
  start = Time.now
  delay_in_s = 0.3

  range.each do |offset|

    src = BASE.sub( '{collection}', collection ).
               sub( '{offset}', offset.to_s )

    dest = "./#{collection}/meta/#{offset}.json"

    puts "==> #{offset} - GET #{src}..."
    copy_json( src, dest )

    puts "sleeping #{delay_in_s}s..."
    sleep( delay_in_s )

    stop = Time.now
    diff = stop - start

    mins = diff / 60  ## todo - use floor or such?
    secs = diff % 60
    puts "up #{mins} mins #{secs} secs (total #{diff} secs)"
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




#############
# read meta data into struct

class Meta
  def initialize( txt )
    @data = JSON.parse( txt )

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

  def token_id    ## note: keep id as string as is - why? why not?
    @token_id ||= @asset['token_id']
  end



  def traits
    @traits ||= begin
                   traits = {}
                   @asset[ 'traits' ].each do |t|
                      trait_type = t['trait_type'].strip
                      h = {}
                      if traits.has_key?( trait_type )
                        puts "!! error - duplicate trait type >#{trait_type}< not allowed for now, sorry"
                        pp @assets['traits']
                        puts "---"
                        pp @data
                        exit 1
                      end
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


def read_meta( path )
  txt = File.open( path, 'r:utf-8') { |f| f.read }
  meta = Meta.new( txt )
  meta
end



