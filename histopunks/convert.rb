##################
#  special case
#    convert via magick from jpg format to .png
#
# to run use:
#    $ ruby histopunks/convert.rb


require_relative '../helper'


collection = 'histopunks'


convert_images( collection )

puts "bye"

