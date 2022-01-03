#####
# to run use:
#   $ ruby blockydogeguilds/download.rb


require_relative '../helper'


# https://opensea.io/collection/blockydogeguilds  - 1000 items

c = Collection.new( 'blockydogeguilds', 1000 )

c.download_meta
c.download_images


puts "bye"
