#####
# to run use:
#   $ ruby wow-pixies-v2/convert.rb


require_relative '../artbase'


collection = 'wow-pixies-v2'

convert_images( collection,
                   from: 'jpg', to: 'png',
                   dir: 'token-i',
                   overwrite: false )


puts "bye"

