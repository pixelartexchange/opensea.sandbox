#####
# to run use:
#   $ ruby bladerunner-punks/download.rb


require_relative '../helper'





# https://opensea.io/collection/bladerunner-punks

collection = 'bladerunner-punks'


range      = (24..999)   #  first 1000 items

download_meta( range, collection )


##
# note - [16,23].json is missing image urls

download_images( range, collection )

puts "bye"

