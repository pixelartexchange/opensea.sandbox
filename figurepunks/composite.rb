
require_relative '../helper'


collection = 'figurepunks'  # 408 items



punks = ImageComposite.new( 25, 17 )                    ## 25x17 = 425

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "../collections/figurepunks-24x24.png" )


puts "bye"

