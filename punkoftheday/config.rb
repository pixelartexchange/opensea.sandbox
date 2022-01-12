
### note: one punk added per day ??
COLLECTION = Collection.new( 'punkoftheday', 12,  # items as of 12/Jan/2022


meta_slugify: ->(meta, index) {
   #####
   #  January 1, 2022 - Lorenzo de' Medici
   #  January 9, 2022  - Rod Stewart
   #  January 11, 2022 - Mary J. Blige
   #  January 12, 2022 - Howard Stern

   name = if m=meta.name.match( /^.*, 2022 - (?<name>.+)$/ )
               m[:name].strip
          else
               puts "!! ERROR - cannot find name:"
               pp meta
               exit 1
          end

slug = slugify( name )

puts "==> #{index}  - #{meta.name} => #{name} | #{slug}"

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



