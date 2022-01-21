

### note: convert jpgs (1 e.g. 81) to pngs
#        convert gifs (1 e.g. 501)

# convert_images( collection, from: 'jpg' )
# convert_images( collection, from: 'gif' )



COLLECTION = Collection.new( 'youtubepunks', 502,
####
# filter out/skip  when pixelate / rarity & popularity attributes:
exclude: [
  "Hello Kitty and Friends #155",     # cat with hi-res lines / whiskers
  "First 31 Days #000",               # hi-res image composite
],


#################
# e.g. Cody Ko #018      => 18
#      Guava Juice #491  => 491
meta_slugify:  /^(?<name>.+)[ ]+#(?<num>[0-9]+)$/,

image_pixelate: ->(img) {
    if img.width == 512 && img.height == 512
      img.pixelate( from: '512x512', to: '24x24' )
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end
}
)


