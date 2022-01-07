
require_relative '../helper'



collection = 'goodbye-punks'
range      =  (0..99)   # 100 items



counter = {}

range.each do |id|

    meta = OpenSea::Meta.read( "./#{collection}/meta/#{id}.json" )

    #####
    #  Goodbye Punk #95  => 95
    #  Goodbuy Punk #372 => 372
    #  Good Bye #1157    => 1157
    num =  if m=meta.name.match( /^Good(bye|buy) Punk #(?<num>[0-9]+)$/ ) ||
                meta.name.match( /^Good Bye #(?<num>[0-9]+)$/ )
             m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
           else
              puts "!! ERROR - cannot find id number in >#{meta.name}<:"
              pp meta
              exit 1
           end

    puts "==> #{num} - #{meta.name}"
    pp  meta.traits


    rec = counter[ 'Attribute Count'] ||= { count: 0,
                                            by_type: Hash.new(0)
                                          }
    rec[ :count ] +=1

    ## note: only include Accessory traits in count!!!!
    rec[ :by_type ][
      meta.traits.select { |t| t[0]=='Accessory' }.size ] += 1


    meta.traits.each do |trait_type, trait_value|
        rec = counter[ trait_type ] ||= { count: 0,
                                          by_type: Hash.new(0)
                                        }
        rec[ :count ] +=1
        rec[ :by_type ][ trait_value ] += 1
    end
end




puts
pp counter


puts
counter_to_csv( counter )

puts
counter_to_text( counter)


puts "bye"


