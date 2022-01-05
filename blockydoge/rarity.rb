
require_relative '../helper'



collection = 'blockydoge'
range      =  (0..99)   # 100 items



counter = {}

range.each do |id|

    meta = OpenSea::Meta.read( "./#{collection}/meta/#{id}.json" )

    #####
    #  Blocky Doge #1  => 1
    num =  if m=meta.name.match( /^Blocky Doge #(?<num>[0-9]+)$/ )
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
    rec[ :by_type ][ meta.traits.size ] += 1


    meta.traits.each do |trait_type, trait_value|
        rec = counter[ trait_type ] ||= { count: 0,
                                          by_type: Hash.new(0)
                                        }
        rec[ :count ] +=1
        rec[ :by_type ][ trait_value ] += 1
    end
end


def counter_to_csv( counter )

  puts "type, name, count"
  counter.each do |trait_type, h|
    puts "#{trait_type}, ∑ Total, #{h[:count]}"
    h[:by_type].each do |trait_value, count|
       puts "#{trait_type}, #{trait_value}, #{count}"
    end
  end
end



puts
pp counter


puts
counter_to_csv( counter )


puts "bye"


