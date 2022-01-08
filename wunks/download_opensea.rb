#####
# to run use:
#   $ ruby wunks/download_opensea.rb


require_relative '../helper'

### note: total is 5255!!!
c = Collection.new( 'wunks', 5255 )  # items as of 8/Jan/2022

c.download_meta
# c.download_images



puts "bye"


