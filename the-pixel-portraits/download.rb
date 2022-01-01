#####
# to run use:
#   $ ruby the-pixel-portraits/download.rb


require_relative '../helper'


# https://opensea.io/collection/the-pixel-portraits  - 532 items (as of 1/1/2022)

c = Collection.new( 'the-pixel-portraits', 532 )
# c.download_meta

## note:  mata 520.json is missing image_url / skip for now

range = (521..531)
c.download_images( range )


puts "bye"
