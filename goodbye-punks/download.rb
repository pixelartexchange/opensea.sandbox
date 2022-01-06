#####
# to run use:
#   $ ruby goodbye-punks/download.rb


require_relative '../helper'


# https://opensea.io/collection/goodbye-punks  - 100 items

c = Collection.new( 'goodbye-punks', 100 )

c.download_meta
c.download_images


puts "bye"
