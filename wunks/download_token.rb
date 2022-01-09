#####
# to run use:
#   $ ruby wunks/download_token.rb


require_relative '../helper'


### use/try direct link via baseURI from contract
# https://blam.io/api/10fa10e5-7570-4b32-84a8-e23e032b60da/token/0


c = TokenCollection.new( 'wunks', 6000,
                          token_base: 'https://blam.io/api/10fa10e5-7570-4b32-84a8-e23e032b60da/token/{id}' )

# range = (5255..5999)
# c.download_meta( range )

range = (5255..5999)
c.download_images( range )



puts "bye"


