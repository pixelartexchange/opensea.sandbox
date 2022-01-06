
require_relative '../helper'


collection = 'goodbye-punks'

punks = ImageComposite.new( 10, 10 )

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "../collections/goodbyepunks-24x24.png" )
punks.zoom(2).save( "./tmp/goodbyepunks-24x24@2x.png" )

puts "bye"

