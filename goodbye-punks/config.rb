

# https://opensea.io/collection/goodbye-punks  - 100 items

COLLECTION  = Collection.new( 'goodbye-punks', 100,


#####
#  Goodbye Punk #95  => 95
#  Goodbuy Punk #372 => 372
#  Good Bye #1157    => 1157
meta_slugify: [/^Good(bye|buy) Punk #(?<num>[0-9]+)$/,
               /^Good Bye #(?<num>[0-9]+)$/],

image_pixelate: ->(img) {
  if img.width == 512 && img.height == 512
    img.pixelate( from: '512x512', to: '24x24' )
  else
    puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
    exit 1
  end
}
)

