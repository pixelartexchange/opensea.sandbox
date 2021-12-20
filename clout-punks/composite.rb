
require_relative '../helper'


collection = 'clout-punks'



punks = ImageComposite.new( 25, 20 )                    ## 25x20 = 500

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "./collection/clout.png" )
punks.zoom(2).save( "./collection/clout@2x.png" )
# punks.zoom(4).save( "./collection/clout@4x.png" )

puts "bye"

