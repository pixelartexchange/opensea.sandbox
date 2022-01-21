
COLLECTION = Collection.new( 'blockydogeguilds', 1000,

####
#  #1 Blocky Doge: Guilds    => 1
#  #536 Blocky Doge: Guilds  => 536
meta_slugify: /^#(?<num>[0-9]+) Blocky Doge: Guilds$/,


image_pixelate: ->(img) {
    if img.width == 512 && img.height == 512
      img.pixelate( from: '512x512', to: '80x80' )
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end
}
)


