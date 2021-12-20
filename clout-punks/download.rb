#####
# to run use:
#   $ ruby clout-punks/download.rb


require_relative '../helper'





# https://opensea.io/collection/clout-punks

collection = 'clout-punks'


range      = (0..499)   #  500 items

# download_meta( range, collection )

# download_images( range, collection )

######
# note: convert jpgs (2 e.g 350, 498) to pngs
#       convert gifs (1 e.g 450) to pngs

convert_images( collection, from: 'jpg' )

convert_images( collection, from: 'gif' )


puts "bye"

