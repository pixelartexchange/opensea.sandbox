
require_relative '../artbase'


collection = 'dooggies'

punks = ImageComposite.new( 100, 100, width: 32, height: 32 )   # 100x100 = 10000

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "../collections/dooggies-32x32.png" )

puts "bye"

