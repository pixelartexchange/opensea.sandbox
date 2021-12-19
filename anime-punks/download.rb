#####
# to run use:
#   $ ruby anime-punks/download.rb


require_relative '../helper'





# https://opensea.io/collection/anime-punks

collection = 'anime-punks'
range      = (0..974)   # 975 items

download_meta( range, collection )

download_images( range, collection )

## note: some images are in jpg (142), some in gif (11), most in png
convert_images( collection, from: 'jpg' )
convert_images( collection, from: 'gif' )

# [1/11] - magick convert ./anime-punks/i/375.gif ./anime-punks/i/375.png
# [2/11] - magick convert ./anime-punks/i/403.gif ./anime-punks/i/403.png
# [3/11] - magick convert ./anime-punks/i/404.gif ./anime-punks/i/404.png
# [4/11] - magick convert ./anime-punks/i/405.gif ./anime-punks/i/405.png
# [5/11] - magick convert ./anime-punks/i/406.gif ./anime-punks/i/406.png
# [6/11] - magick convert ./anime-punks/i/407.gif ./anime-punks/i/407.png
# [7/11] - magick convert ./anime-punks/i/408.gif ./anime-punks/i/408.png
# [8/11] - magick convert ./anime-punks/i/409.gif ./anime-punks/i/409.png
# [9/11] - magick convert ./anime-punks/i/410.gif ./anime-punks/i/410.png
# [10/11] - magick convert ./anime-punks/i/411.gif ./anime-punks/i/411.png
# [11/11] - magick convert ./anime-punks/i/412.gif ./anime-punks/i/412.png


## todo: filter out
##   no. 87 - is "rotated" special artwork (78x128)
##   no. 375 - is not "scaled" pixel artwork (512x512)



puts "bye"

