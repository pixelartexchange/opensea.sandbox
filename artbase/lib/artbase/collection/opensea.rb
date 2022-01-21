

class Collection    ## todo/check - change to OpenseaCollection or such - why? why not?

attr_reader :slug, :count

def initialize( slug, count,   # check: rename count to items or such - why? why not?
                meta_slugify: nil,
                image_pixelate: nil,
                exclude: [] )
  @slug = slug
  @count = count

  @meta_slugify   = meta_slugify
  @image_pixelate = image_pixelate

  @exclude = exclude
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



def _meta_slugify( meta, index )

  slug = nil

  #########################
  ## case 1 - regexp
  if @meta_slugify.is_a?( Regexp )
    if m=meta.name.match( @meta_slugify )
       captures = m.named_captures   ## get named captures in match data as hash (keys as strings)
       # e.g.
       #=> {"num"=>"3"}
       #=> {"num"=>"498", "name"=>"Doge"}
       pp captures

       num  = captures['num']  ? captures['num'].to_i( 10 ) : nil   ## note: add base 10 (e.g. 015=>15)
       name = captures['name'] ? captures['name'].strip     : nil

       slug = ''
       if num
         slug << "%06d" % num    ## todo/check: always fill/zero-pad with six 000000's - why? why not?
       end

       if name
         slug << "-"   if num   ## add separator
         slug << slugify( name )
       end
    else
      puts "!! ERROR - cannot find id in >#{meta.name}<:"
      pp meta
      exit 1
    end
   ##########################
   ## case 2 - proc   - todo/fix: check for return type and support MatchData - why? why not??
   elsif @meta_slugify.is_a?( Proc )
     slug = @meta_slugify.call( meta, index )
   else
     raise ArgumentError, "meta_slugify - unsupported type: #{@meta_slugify.class.name}"
   end

   slug
end


def dump_attributes
  counter = {}

  range=(0...@count)
  range.each do |id|

    meta = OpenSea::Meta.read( "./#{@slug}/meta/#{id}.json" )

    ####
    # filter out/skip
    if @exclude.include?( meta.name )
      puts "  skipping / exclude #{id} >#{meta.name}<..."
      next
    end


    traits = meta.traits
    # print "#{traits.size} - "
    # pp  traits


    print "#{id}.."   if id % 100 == 0  ## print progress report


    rec = counter[ 'Attribute Count'] ||= { count: 0,
                                            by_type: Hash.new(0)
                                          }
    rec[ :count ] +=1
    rec[ :by_type ][ traits.size ] += 1


    traits.each do |trait_type, trait_value|
        rec = counter[ trait_type ] ||= { count: 0,
                                          by_type: Hash.new(0)
                                        }
        rec[ :count ] +=1
        rec[ :by_type ][ trait_value ] += 1
    end
  end

  print "\n"
  puts
  pp counter
end


def pixelate( range=(0...@count) )

  meta_slugs = Hash.new( 0 )   ## deduplicate (auto-add counter if duplicate)

  ### todo/fix: must read slugs starting at 0
  ###               to work for deduplicate!!!!!!


  range.each do |id|
    meta = OpenSea::Meta.read( "./#{@slug}/meta/#{id}.json" )

    ####
    # filter out/skip
    if @exclude.include?( meta.name )
       puts "  skipping / exclude #{id} >#{meta.name}<..."
       next
    end

    puts meta.name


    meta_slug = _meta_slugify( meta, id )
    count = meta_slugs[ meta_slug ] += 1

    meta_slug = "#{meta_slug}_(#{count})"  if count > 1


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


def self.download_meta( range, collection )
  start = Time.now
  delay_in_s = 0.3

  range.each do |offset|

    dest = "./#{collection}/meta/#{offset}.json"
    meta = nil

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
