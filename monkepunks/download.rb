#####
# to run use:
#   $ ruby monkepunks/download.rb


require_relative '../helper'





# https://opensea.io/collection/monkepunks

collection = 'monkepunks'
range      = (0..998)   # 999 items

# download_meta( range, collection )

# download_images( range, collection )

convert_images( collection )

puts "bye"

