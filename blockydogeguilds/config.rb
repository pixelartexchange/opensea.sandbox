
COLLECTION = Collection.new( 'blockydogeguilds', 1000,


meta_slugify: ->(meta, index) {

    puts meta.name

    #####
    #  #1 Blocky Doge: Guilds    => 1
    #  #536 Blocky Doge: Guilds => 536
    num =  if m=meta.name.match( /^#(?<num>[0-9]+) Blocky Doge: Guilds$/ )
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
    if img.width == 512 && img.height == 512
      img.pixelate( from: '512x512', to: '80x80' )
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end
}
)


