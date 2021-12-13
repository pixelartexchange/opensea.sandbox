##################
# to run use:
#    $ ruby histopunks/download_images.rb


require_relative '../helper'


collection = 'histopunks'
range      = (3..147)   # 148 items



###
##
## note: images are in .jpeg format !!! (default assumes .png)
##   JPEG 512x512 512x512+0+0 8-bit sRGB 16258B 0.016u 0:00.095

download_images( range, collection )

