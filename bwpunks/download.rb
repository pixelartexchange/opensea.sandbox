#####
# to run use:
#   $ ruby bwpunks/download.rb


require_relative '../helper'





# https://opensea.io/collection/bwpunks

collection = 'bwpunks'
range      = (0..149)   # 150 items

# download_meta( range, collection )

download_images( range, collection )


puts "bye"

