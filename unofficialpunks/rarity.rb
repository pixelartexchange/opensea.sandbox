
require_relative '../helper'


collection = 'unofficialpunks'
range      = (0..99)   # 100 items


counter = {}

range.each do |id|

    meta = OpenSea::Meta.read( "./#{collection}/meta/#{id}.json" )


    puts "==> #{id} - #{meta.name}"
    pp  meta.traits


    rec = counter[ 'Attribute Count'] ||= { count: 0,
                                            by_type: Hash.new(0)
                                          }
    rec[ :count ] +=1

    ## note: only include Accessory traits in count!!!!
    # rec[ :by_type ][
    #  meta.traits.select { |t| t[0]=='Accessory' }.size ] += 1
    rec[ :by_type ][ meta.traits.size ] += 1


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



puts "bye"


