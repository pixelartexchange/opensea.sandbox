
require_relative '../helper'


collection = 'genius-punks'


punks = ImageComposite.new( 6, 6 )                    ## 36x36 = 36

punks.add_glob( "./#{collection}/ii/*.png" )


punks.save( "./collection/genius-ii.png" )
punks.zoom(2).save( "./collection/genius-ii@2x.png" )
punks.zoom(4).save( "./collection/genius-ii@4x.png" )



####
#  tech billionaires
punks = ImageComposite.new( 5, 1 )

punks << Image.read( "./#{collection}/ii/009-bill_gates.png" )
punks << Image.read( "./#{collection}/ii/011-steve_jobs.png" )
punks << Image.read( "./#{collection}/ii/010-jeff_bezos.png" )
punks << Image.read( "./#{collection}/ii/029-mark_zuckerberg.png" )
punks << Image.read( "./#{collection}/ii/024-elon_musk.png" )


punks.save( "./#{collection}/tmp/tech.png" )
punks.zoom(2).save( "./#{collection}/tmp/tech@2x.png" )
punks.zoom(4).save( "./#{collection}/tmp/tech@4x.png" )

puts "bye"

