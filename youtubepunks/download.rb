#####
# to run use:
#   $ ruby youtubepunks/download.rb


require_relative '../helper'





# https://opensea.io/collection/youtubepunks

collection = 'youtubepunks'


range      = (0..501)   #  502 items

download_meta( range, collection )

download_images( range, collection )

## note: convert jpgs (1 e.g. 81) to pngs
#        convert gifs (1 e.g. 501)

convert_images( collection, from: 'jpg' )
convert_images( collection, from: 'gif' )

puts "bye"

