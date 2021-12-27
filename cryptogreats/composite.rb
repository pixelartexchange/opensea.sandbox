
require_relative '../helper'


collection = 'cryptogreats'



punks = ImageComposite.new( 25, 33, width: 32, height: 32 )                    ## 25x33= 825

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "./collection/greats.png" )
punks.zoom(2).save( "./collection/greats@2x.png" )

puts "bye"

