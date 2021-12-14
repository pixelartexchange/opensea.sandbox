#####
# to run use:
#   $ ruby athletes-101/download_meta.rb


require_relative '../helper'





# https://opensea.io/collection/athletes-101

collection = 'athletes-101'
range      = (0..34)   # 35 items


download_meta( range, collection )

puts "bye"

