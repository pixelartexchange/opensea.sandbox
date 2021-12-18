#####
# to run use:
#   $ ruby scifipunks/download.rb


require_relative '../helper'





# https://opensea.io/collection/scifipunks

collection = 'scifipunks'
range      = (0..93)   # 94 items

download_meta( range, collection )

download_images( range, collection )

## note: most images are in jpg, one in gif, some in png
convert_images( collection, from: 'jpg' )
convert_images( collection, from: 'gif' )


puts "bye"

