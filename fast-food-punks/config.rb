
# https://opensea.io/collection/fast-food-punks  - 1000 items



COLLECTION = Collection.new( 'fast-food-punks', 1000,

meta_slugify: ->(meta, index) {
   #####
   # Fast Food Punks 001 => 1
   # Fast Food Punks 002 => 2
   # Fast Food Punk 111  => 111
   num = if m=meta.name.match( /^Fast Food Punks? (?<num>[0-9]+)$/ )
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
   ###  Fast Food Punks 145 => 145 | 0145
   ##     image dimension 269x269

  if img.width == 512 && img.height == 512
    img.pixelate( Image::PIXEL_OFFSETS[ '512x512']['24x24'] )
  elsif img.width == 269 && img.height == 269
    img.pixelate( Image::PIXEL_OFFSETS[ '269x269']['24x24'] )
  else
    puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
    exit 1
  end
}
)

