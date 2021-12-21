
require_relative '../helper'


collection = 'cinepunkss'


punks = ImageComposite.new( 20, 19 )   ## 20x19 = 380
punks.add_glob( "./#{collection}/ii/*.png" )

punks.save( "./collection/cinema.png" )
punks.zoom(2).save( "./collection/cinema@2x.png" )

puts "bye"

