#####
# to run use:
#   $ ruby cryptoluxurypunks/download.rb


require_relative '../helper'


# https://opensea.io/collection/cryptoluxurypunks  - 6621 items (as of 2/1/2022)

c = Collection.new( 'cryptoluxurypunks', 6621 )
c.download_meta
c.download_images


puts "bye"
