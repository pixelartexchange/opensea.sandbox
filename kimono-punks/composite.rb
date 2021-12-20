
require_relative '../helper'


collection = 'kimono-punks'

punks = ImageComposite.new( 10, 13,                    ## 10x13 = 130
                            width: 27, height: 27 )

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "./collection/kimono.png" )
punks.zoom(2).save( "./collection/kimono@2x.png" )
punks.zoom(4).save( "./collection/kimono@4x.png" )

puts "bye"

