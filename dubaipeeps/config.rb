
### note: total is 1000 !!!
COLLECTION = Collection.new( 'dubaipeeps', 338,  # items as of 9/Jan/2022


meta_slugify: ->(meta, index) {
   #####
   #  Abby Special Edition
   #  Abby Special Edition
   #  Jaipzzz Special Edition
   #  Himari
   #  The Emirati Special Edition
   #  ...

   ## note: deduplicate (with _(2), _(3) gets handled in loop)

  slug = slugify( meta.name )

  puts "==> #{index}  - #{meta.name} =>  #{slug}"

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



