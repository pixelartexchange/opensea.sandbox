#####
# to run use:
#   $ ruby onlypunksnft/download_meta.rb


require_relative '../helper'





# https://opensea.io/collection/onlypunksnft

collection = 'onlypunksnft'

# note: only download first 200 items for now
#     add some extras to 100 to skip zombies, apes, etc. and only get 100 "proper" females
range      =  (0..199)

download_meta( range, collection )

puts "bye"


