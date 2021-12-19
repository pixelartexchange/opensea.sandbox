#####
# to run use:
#   $ ruby dogepunks-collection/download.rb


require_relative '../helper'





# https://opensea.io/collection/dogepunks-collection

collection = 'dogepunks-collection'
range      = (0..149)   # 150 items

download_meta( range, collection )

download_images( range, collection )

puts "bye"

