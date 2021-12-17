
require_relative '../helper'

#
 ##
  #          OnlyPunk #316  in 180.json
  #
  #  todo/fix - check why this error????
  #   !! ERROR - cannot find id number in >OnlyPunk #316<:


collection = 'onlypunksnft'

meta =   read_meta( "./#{collection}/meta/180.json" )

pp meta.name

traits = meta.traits
pp traits


num  =  if m=meta.name.gsub( "\u{00a0}", ' ').match( /^OnlyPunk #(?<num>[0-9]+)/ )
  m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
else
puts "!! ERROR - cannot find id number in >#{meta.name}<:"
end

