#####
# to run use:
#   $ ruby cinepunkss/download.rb


require_relative '../helper'





# https://opensea.io/collection/cinepunkss

collection = 'cinepunkss'


range      = (0..360)   #  361 items

download_meta( range, collection )

download_images( range, collection )

# note: convert jpgs (3 e.g. 152.jpg, 305.jpg, 321.jpg)  to pngs
convert_images( collection )
puts "bye"

