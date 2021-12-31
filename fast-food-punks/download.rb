#####
# to run use:
#   $ ruby fast-food-punks/download.rb


require_relative '../helper'


# https://opensea.io/collection/fast-food-punks  - 1000 items

c = Collection.new( 'fast-food-punks', 1000 )
c.download_meta
# c.download_images


puts "bye"
