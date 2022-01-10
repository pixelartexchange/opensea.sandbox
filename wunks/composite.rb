
require_relative '../helper'


collection = 'wunks'

punks = ImageComposite.new( 100, 60 )  # 100x60 = 6000

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "../collections/womenpunks/womenpunks-24x24.png" )

puts "bye"

