
### note: total is supposed to be 10 000 !!!

## change to  pleasenopurchase ??
COLLECTION = Collection.new( 'dooggies', 9993,  # items as of 17/Jan/2022


meta_slugify: ->(meta, index) {
  num =  if m=meta.name.match( /^Dooggie #(?<num>[0-9]+)$/ )
    m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
  else
     puts "!! ERROR - cannot find id number in >#{meta.name}<:"
     pp meta
     exit 1
  end

  slug = '%05d' % num

  puts "==> #{index}  - #{meta.name} =>  #{slug}"

  slug
},

image_pixelate: ->(img) {
  if img.width == 320 && img.height == 320
    img.pixelate( Image::PIXEL_OFFSETS[ '320x320']['32x32'] )
  else
    puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
    exit 1
  end
}
)

