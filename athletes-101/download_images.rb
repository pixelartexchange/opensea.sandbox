##################
# to run use:
#    $ ruby athletes-101/download_images.rb


require_relative '../helper'


collection = 'athletes-101'
range      = (0..34)   # 35 items



download_images( range, collection )

###
## note: images are in .jpeg format !!! (default assumes .png)
##   requires "post-process" conversion (to .png)
convert_images( collection )

