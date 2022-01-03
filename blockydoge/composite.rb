
require_relative '../helper'


collection = 'blockydoge'

punks = ImageComposite.new( 10, 10,                    ## 10x10 = 100
                            width: 60, height: 60 )

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "../collections/blockydoge-60x60.png" )

puts "bye"

