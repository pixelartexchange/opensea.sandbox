#####
# to run use:
#   $ ruby blockydoge/download.rb


require_relative '../helper'


# https://opensea.io/collection/blockydoge  - 100 items

c = Collection.new( 'blockydoge', 100 )
c.download_meta
c.download_images


puts "bye"
