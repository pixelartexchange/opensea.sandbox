##################
# to run use:
#    $ ruby thecryptogenius/download_images.rb


require_relative '../helper'



collection = 'unofficialpunks'
range      = (0..99)   # 100 items


download_images( range, collection )

