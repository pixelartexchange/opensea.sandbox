#####
# to run use:
#   $ ruby kimono-punks/download.rb


require_relative '../helper'





# https://opensea.io/collection/kimono-punks

collection = 'kimono-punks'
range      =  (128..150) #(126..128) # (128..584) # (0..584)   # 585 items

download_meta( range, collection )


###
# todo/fix:
#   check download_meta result for empty assets!!!
#      and quit / stop on error!!!!
#  always parse meta for checking!! and print/dump name!!!
##  no more results startin with offset 128 - but shows 585 items - retry later !!!!



# download_images( range, collection )


####
#  note: convert jpgs (20+) to pngs
#        convert gifs (3) to pngs
#    [1/3] - magick convert ./kimono-punks/i/59.gif ./kimono-punks/i/59.png
#    [2/3] - magick convert ./kimono-punks/i/60.gif ./kimono-punks/i/60.png
#    [3/3] - magick convert ./kimono-punks/i/61.gif ./kimono-punks/i/61.png
#
# convert_images( collection, from: 'jpg' )
# convert_images( collection, from: 'gif' )


puts "bye"

