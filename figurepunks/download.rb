#####
# to run use:
#   $ ruby figurepunks/download.rb


require_relative '../helper'





# https://opensea.io/collection/figurepunks

collection = 'figurepunks'
range      = (0..430)   # 431 items

download_meta( range, collection )

download_images( range, collection )


#####
# note: convert gifs (5 e.g 264, 265, 266, 307, 318) to pngs
convert_images( collection, from: 'jpg' )
convert_images( collection, from: 'gif' )




puts "bye"

