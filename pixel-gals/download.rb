#####
# to run use:
#   $ ruby pixel-gals/download.rb


require_relative '../helper'


# https://opensea.io/collection/pixel-gals  - 33 items


## note: for now returns empty assets records !!!!!!!
##   check - missing a flag or something in query???

c = Collection.new( 'pixel-gals', 33 )
c.download_meta
c.download_images


puts "bye"

