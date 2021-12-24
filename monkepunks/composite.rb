
require_relative '../helper'


collection = 'monkepunks'

punks = ImageComposite.new( 25, 40,                    ## 25x40 = 1000
                            width: 34, height: 34 )

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "./collection/monkey.png" )
punks.zoom(2).save( "./collection/monkey@2x.png" )

puts "bye"

