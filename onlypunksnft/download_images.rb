##################
# to run use:
#    $ ruby onlypunksnft/download_images.rb


require_relative '../helper'



collection = 'onlypunksnft'
range      = (120..199)  #  (58..119)


download_images( range, collection )

