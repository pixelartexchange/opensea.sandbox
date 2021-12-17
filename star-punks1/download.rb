#####
# to run use:
#   $ ruby star-punks1/download.rb


require_relative '../helper'





# https://opensea.io/collection/star-punks1

collection = 'star-punks1'
range      = (0..441)   # 442 items


download_meta( range, collection )

download_images( range, collection )



puts "bye"

