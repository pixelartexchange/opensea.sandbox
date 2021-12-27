#####
# to run use:
#   $ ruby cryptogreats/download.rb


require_relative '../helper'





# https://opensea.io/collection/cryptogreats

collection = 'cryptogreats'


range      = (0..817)   #  818 items

download_meta( range, collection )

download_images( range, collection )


#####
# note: convert gifs (4 e.g 801, 802, 803, 805, 817) to pngs

convert_images( collection, from: 'gif' )



puts "bye"

