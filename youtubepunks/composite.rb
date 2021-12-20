
require_relative '../helper'



collection = 'youtubepunks'

punks = ImageComposite.new( 20, 25 )   ## 20x25 = 500
punks.add_glob( "./#{collection}/ii/*.png" )

punks.save( "./collection/youtube.png" )
punks.zoom(2).save( "./collection/youtube@2x.png" )

puts "bye"

