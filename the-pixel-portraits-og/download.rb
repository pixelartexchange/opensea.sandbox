#####
# to run use:
#   $ ruby the-pixel-portraits-og/download.rb


require_relative '../helper'


# https://opensea.io/collection/the-pixel-portraits-og  - 1005 items (as of 1/1/2022)

c = Collection.new( 'the-pixel-portraits-og', 1005 )
# c.download_meta
c.download_images


puts "bye"
