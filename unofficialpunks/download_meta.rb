#####
# to run use:
#   $ ruby unofficialpunks/download_meta.rb


require_relative '../helper'





# https://opensea.io/collection/unofficialpunks

collection = 'unofficialpunks'
range      = (0..99)   # 100 items


download_meta( range, collection )

puts "bye"

