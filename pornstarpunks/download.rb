#####
# to run use:
#   $ ruby pornstarpunks/download.rb


require_relative '../helper'





# https://opensea.io/collection/pornstarpunks

collection = 'pornstarpunks'


range      = (0..89)   #  90 items

# download_meta( range, collection )

download_images( range, collection )
puts "bye"

