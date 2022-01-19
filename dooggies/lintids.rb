
require_relative '../artbase'


collection = 'dooggies'


ids = Hash.new( 0 )



files = Dir.glob( "./#{collection}/meta/*.json" )

puts "  #{files.size} files "
#=> 9993 files

files.each_with_index do |file,i|

  print "." if i % 100

  meta = Opensea::Meta.read( file )
  ## puts meta.name

   #####
    #  Dooggie #2 => 2
    num =  if m=meta.name.match( /^Dooggie #(?<num>[0-9]+)$/ )
      m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
    else
       puts "!! ERROR - cannot find id number in >#{meta.name}<:"
       pp meta
       exit 1
    end

    ids[ num ] += 1
end
print "\n"


puts
puts "  #{ids.size} id(s)"
# 9993 ids

## check for missing ids
(0..9999).each do |id|
   count = ids[ id ]

   if count == 0
      puts "BINGO!!  - #{id} missing"
   elsif count > 1
      puts "ERROR!!  - #{id} duplicate with count: #{count}"
   else
      # do nothing
   end
end
puts "bye"

__END__

BINGO!!  - 0 missing
BINGO!!  - 1 missing
BINGO!!  - 139 missing
BINGO!!  - 164 missing
BINGO!!  - 473 missing
BINGO!!  - 531 missing
BINGO!!  - 597 missing

