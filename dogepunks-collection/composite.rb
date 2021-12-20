
require_relative '../helper'


collection = 'dogepunks-collection'

punks = ImageComposite.new( 10, 15,                    ## 10x15 = 150
                            width: 36, height: 36 )

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "./collection/doge.png" )
punks.zoom(2).save( "./collection/doge@2x.png" )
punks.zoom(4).save( "./collection/doge@4x.png" )

puts "bye"

