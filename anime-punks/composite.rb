
require_relative '../helper'


collection = 'anime-punks'

punks = ImageComposite.new( 25, 39,                    ## 25x39 = 975
                            width: 30, height: 30 )

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "./collection/anime.png" )
punks.zoom(2).save( "./collection/anime@2x.png" )
# punks.zoom(4).save( "./collection/anime@4x.png" )

puts "bye"

