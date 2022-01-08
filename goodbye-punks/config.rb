

# https://opensea.io/collection/goodbye-punks  - 100 items

COLLECTION  = Collection.new( 'goodbye-punks', 100,

meta_slugify: ->(meta, index) {
   #####
   #  Goodbye Punk #95  => 95
   #  Goodbuy Punk #372 => 372
   #  Good Bye #1157    => 1157

  num =  if m=meta.name.match( /^Good(bye|buy) Punk #(?<num>[0-9]+)$/ ) ||
              meta.name.match( /^Good Bye #(?<num>[0-9]+)$/ )
                m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
         else
           puts "!! ERROR - cannot find id number in >#{meta.name}<:"
           pp meta
           exit 1
         end

  slug = "%04d" % num

  puts "==> #{index}  - #{meta.name} => #{num} | #{slug}"

  slug
},

image_pixelate: ->(img) {
  if img.width == 512 && img.height == 512
    ## do nothing; everything ok
  else
    puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
    exit 1
  end

  img.pixelate( Image::PIXEL_OFFSETS[ '512x512']['24x24'] )
}
)

