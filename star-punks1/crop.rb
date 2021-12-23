
require_relative '../helper'

collection = 'star-punks1'

img = Image.read( "./#{collection}/ii/britney_spears.png" )

img.crop( 4, 8, 24, 24 ).save( "./#{collection}/tmp/britney_spears@24x24.png" )

puts "bye"

