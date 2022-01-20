

COLLECTION = Collection.new( 'blockydoge', 100,


meta_slugify: ->(meta, index) {

    puts meta.name

    #####
    #  Blocky Doge #1  => 1
    num =  if m=meta.name.match( /^Blocky Doge #(?<num>[0-9]+)$/ )
             m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
           else
              puts "!! ERROR - cannot find id number in >#{meta.name}<:"
              pp meta
              exit 1
           end

     slug = "%03d" % num

     puts "==> #{index}  - #{meta.name} => #{num} | #{slug}"

     slug
},

image_pixelate: ->(img) {
    if img.width == 512 && img.height == 512
      img.pixelate( from: '512x512', to: '60x60' )
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end
}
)
