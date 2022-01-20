

### note: convert jpgs (1 e.g. 81) to pngs
#        convert gifs (1 e.g. 501)

# convert_images( collection, from: 'jpg' )
# convert_images( collection, from: 'gif' )



COLLECTION = Collection.new( 'youtubepunks', 502,
####
# filter out/skip  when pixelate:
#   no. 155 - cat with hi-res lines / whiskers
#   no. 252 - hi-res image composite
exclude: [155, 252],


meta_slugify: ->(meta, index) {

    puts meta.name

    # e.g. Cody Ko #018      => 18
    #      Guava Juice #491  => 491

    name, num  =  if m=meta.name.match( /^(?<name>.+)[ ]+#(?<num>[0-9]+)$/ )
                     [m[:name].strip,
                      m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
                     ]
                  else
                    puts "!! ERROR - cannot find id number in #{meta.name}:"
                    pp meta
                    exit 1
                  end

    slug = "%03d" % num
    slug << "-"
    slug << slugify( name )

    puts "==> #{index}  - #{name} => #{num} | #{slug}"

    slug
},

image_pixelate: ->(img) {
    if img.width == 512 && img.height == 512
      img.pixelate( from: '512x512', to: '24x24' )
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end
}
)


