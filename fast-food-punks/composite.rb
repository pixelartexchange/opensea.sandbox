
require_relative '../artbase'


collection = 'fast-food-punks'

punks = ImageComposite.new( 25, 40 )   # 25x40 = 1000

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "../collections/fastfoodpunks-24x24.png" )
punks.zoom(2).save( "./tmp/fastfoodpunks-24x24@2x.png" )

puts "bye"

