
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



def counter_to_text( counter )

  counter = counter.to_a

  attribute_counter = counter[0]
  more_counter      = counter[1..-1]


  puts "Attribute Count\n"
  trait_type, h = attribute_counter

  types = h[:by_type]
  types = types.sort { |l,r| r[0]<=>l[0] }  ## sort by name
  types.each do |rec|
      puts "- #{rec[0]} => #{rec[1]}"
  end
  puts "\n"

  more_counter.each_with_index do |(trait_type, h),i|
    print " · "  if i > 0   ## add separator
    puts "#{trait_type } (#{h[:by_type].size})"
  end
  puts "\n\n"



  more_counter.each do |trait_type, h|
    puts "### #{trait_type } (#{h[:by_type].size})\n"
    puts "∑ Total #{h[:count]}:\n"

      types = h[:by_type]
      types = types.sort do |l,r|
                            # sort by 1) by count
                            #         2) by name a-z
                                  res = r[1] <=> l[1]
                                  res = l[0] <=> r[0]  if res == 0
                                  res
                         end  ## sort by count
      types.each do |rec|
         puts "- #{rec[0]} => #{rec[1]}"
      end
      puts "\n\n"
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

puts
# counter_to_text( counter )



puts "bye"


