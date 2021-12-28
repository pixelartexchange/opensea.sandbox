#####
# to run use:
#   $ ruby pixelmeows/download.rb


require_relative '../helper'





# https://opensea.io/collection/pixelmeows

collection = 'pixelmeows'
range      = (0..99)   # 100 items

download_meta( range, collection )

download_images( range, collection )

puts "bye"

