#####
# to run use:
#   $ ruby mafia-punks-club/download_meta.rb


require_relative '../helper'





# https://opensea.io/collection/mafia-punks-club

collection = 'mafia-punks-club'
range      = (0..194)   # 195 items


download_meta( range, collection )

puts "bye"

