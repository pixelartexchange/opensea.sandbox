##################
#  special case
#    convert via magick from jpg format to .png
#
# to run use:
#    $ ruby thecryptogenius/convert.rb


require_relative '../helper'


collection = 'thecryptogenius'


convert_images( collection )


puts "bye"
