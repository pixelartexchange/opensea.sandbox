#####
# to run use:
#   $ ruby cryptowiener-4/download.rb


require_relative '../helper'





# https://opensea.io/collection/cryptowiener-4

collection = 'cryptowiener-4'
range      = (0..199)   # 200 items

download_meta( range, collection )

download_images( range, collection )

## note: seven (7) images in the collection are in jpg (convert to png)
##      [1/7] - magick convert ./cryptowiener-4/i/120.jpg ./cryptowiener-4/i/120.png
#   [2/7] - magick convert ./cryptowiener-4/i/127.jpg ./cryptowiener-4/i/127.png
#   [3/7] - magick convert ./cryptowiener-4/i/2.jpg ./cryptowiener-4/i/2.png
#   [4/7] - magick convert ./cryptowiener-4/i/31.jpg ./cryptowiener-4/i/31.png
#   [5/7] - magick convert ./cryptowiener-4/i/41.jpg ./cryptowiener-4/i/41.png
#   [6/7] - magick convert ./cryptowiener-4/i/42.jpg ./cryptowiener-4/i/42.png
#   [7/7] - magick convert ./cryptowiener-4/i/90.jpg ./cryptowiener-4/i/90.png

convert_images( collection )


puts "bye"

