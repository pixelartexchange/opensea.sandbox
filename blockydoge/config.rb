

COLLECTION = Collection.new( 'blockydoge', 100,

#####
#  Blocky Doge #1  => 1
meta_slugify: /^Blocky Doge #(?<num>[0-9]+)$/,


image_pixelate: ->(img) {
    if img.width == 512 && img.height == 512
      img.pixelate( from: '512x512', to: '60x60' )
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end
}
)
