
require_relative '../helper'


collection = 'blockydogeguilds'
range      =  (0..999)   # 1000 items



counter = {}

range.each do |id|

    meta = OpenSea::Meta.read( "./#{collection}/meta/#{id}.json" )

   #####
    #  #1 Blocky Doge: Guilds    => 1
    #  #536 Blocky Doge: Guilds => 536
    num =  if m=meta.name.match( /^#(?<num>[0-9]+) Blocky Doge: Guilds$/ )
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



puts
pp counter


puts
# counter_to_csv( counter )

puts
counter_to_text( counter )



puts "bye"


