
require_relative '../helper'


collection = 'blockydogeguilds'

punks = ImageComposite.new( 25, 40,                    ## 25x40 = 1000
                            width: 80, height: 80 )

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "../collections/blockydogeguilds-80x80.png" )

puts "bye"

