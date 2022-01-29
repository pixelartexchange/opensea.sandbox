#####
# to run use:
#   $ ruby pornstarpunks/convert.rb


require_relative '../artbase'


collection = 'pornstarpunks'

convert_images( collection,
                   from: 'gif', to: 'png',
                   )


puts "bye"

