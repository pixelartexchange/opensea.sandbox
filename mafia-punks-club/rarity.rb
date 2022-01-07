
require_relative '../helper'



collection = 'mafia-punks-club'
range      = (0..194)   # 195 items



counter = {}

range.each do |id|

    meta = OpenSea::Meta.read( "./#{collection}/meta/#{id}.json" )

   ##
    #    e.g.  Mafia Punks Club #1

    num  =  if m=meta.name.match( /^Mafia Punks Club #(?<num>[0-9]+)/ )
                m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
            else
              puts "!! ERROR - cannot find id number in >#{meta.name}<:"
              pp meta
              exit 1
            end

    puts "==> #{num} - #{meta.name}"
    pp  meta.traits


    ## patch traits
    ##  rename Accessories to Accessory
    meta.traits.each do |t|
      t[0] = 'Accessory'  if t[0] == 'Accessories'

      t[1] = 'Black Hair'  if t[1] == 'Black hair'
      t[1] = 'Bow Tie'     if t[1] == 'Bow tie'
      t[1] = 'Extended Goatee Beard' if t[1] == 'Extended goatee beard'
      t[1] = 'Thin Mustache' if t[1] == 'Thin mustache'
      t[1] = 'White Shirt'  if t[1] == 'White shirt'
      t[1] = 'Black Gangster Hat'  if t[1] == 'Black gangster hat'
      t[1] = 'Foxy Smile'  if t[1] == 'Foxy smile'
      t[1] = 'Gangster Shades'  if t[1] ==  'Gangster shades'
      t[1] = 'Black Shirt'  if t[1] ==  'Black shirt'
    end


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


