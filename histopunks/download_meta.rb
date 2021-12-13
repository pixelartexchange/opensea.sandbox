#####
# to run use:
#   $ ruby histopunks/download_meta.rb


require_relative '../helper'





# https://opensea.io/collection/histopunks

collection = 'histopunks'
range      = (0..147)   # 148 items


download_meta( range, collection )

puts "bye"

