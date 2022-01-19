#####
# to run use:
#   $ ruby dooggies/convert.rb


require_relative '../artbase'


collection = 'dooggies'

convert_images( collection, from: 'gif', to: 'png' )

puts "bye"

