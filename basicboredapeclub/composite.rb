
require_relative '../artbase'


collection = 'basicboredapeclub'

punks = ImageComposite.new( 100, 100,                    ## 100x100 = 10000
                            width: 50, height: 50 )

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "./#{collection}/tmp/#{collection}-50x50.png" )

puts "bye"

