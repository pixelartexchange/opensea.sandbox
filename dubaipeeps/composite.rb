
require_relative '../helper'


collection = 'dubaipeeps'

punks = ImageComposite.new( 25, 14 )   # 25x14 = 350

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "../collections/dubaipunks/dubaipunks-24x24.png" )
punks.zoom(2).save( "./tmp/dubaipeeps-24x24@2x.png" )

puts "bye"

