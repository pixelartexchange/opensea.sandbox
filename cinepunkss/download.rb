#####
# to run use:
#   $ ruby cinepunkss/download.rb


require_relative '../helper'





# https://opensea.io/collection/cinepunkss

collection = 'cinepunkss'


range      = (0..360)   #  361 items

download_meta( range, collection )

download_images( range, collection )
puts "bye"

