#####
# to run use:
#   $ ruby genius-punks/download.rb


require_relative '../helper'





# https://opensea.io/collection/genius-punks

collection = 'genius-punks'
range      = (0..33)   #  34 items

download_meta( range, collection )

download_images( range, collection )

######
#    convert gifs to pngs
convert_images( collection, from: 'gif' )


puts "bye"

