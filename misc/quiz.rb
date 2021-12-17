#############################################
#  generate / create pixel punk quiz composites - who is ___?

require 'pixelart'


pop_rock = [
  Image.read( './thecryptogenius/ii/076-freddie_mercury.png' ),
  Image.read( './thecryptogenius/ii/079-david_bowie.png' ),
  Image.read( './thecryptogenius/ii/082-bob_marley.png' ),

  Image.read( './thecryptogenius/ii/083-jimi_hendrix.png' ),
  Image.read( './unofficialpunks/ii/047-lady_gaga_punk.png' ),
  Image.read( './thecryptogenius/ii/067-michael_jackson.png' ),

  Image.read( './thecryptogenius/ii/072-john_lennon.png' ),
  Image.read( './thecryptogenius/ii/088-whitney_houston.png' ),
  Image.read( './unofficialpunks/ii/051-billie_eilish_punk.png' ),
]


pop_rock_2 = [
  Image.read( './histopunks/ii/032-kurt_cobain.png' ),
  Image.read( './unofficialpunks/ii/094-pink_punk.png' ),
  Image.read( './unofficialpunks/ii/084-snoop_dogg_punk.png' ),

  Image.read( './histopunks/ii/056-prince.png' ),
  Image.read( './unofficialpunks/ii/025-freebritney_britney_spears_punk.png' ),
  Image.read( './unofficialpunks/ii/086-justin_bieber_punk.png' ),

  Image.read( './histopunks/ii/113-eddie_van_halen.png' ),
  Image.read( './unofficialpunks/ii/085-stevie_wonder_punk.png' ),
  Image.read( './histopunks/ii/052-amy_winehouse.png' ),
]



## quiz no. 1
composite = ImageComposite.new( 3, 3 )

pop_rock.each do |punk|
  composite << punk
end

composite.save( "./i/quiz_i.png" )
composite.zoom(2).save( "./i/quiz_i@2x.png" )
composite.zoom(4).save( "./i/quiz_i@4x.png" )


## quiz no. 2
composite = ImageComposite.new( 3, 3 )

pop_rock_2.each do |punk|
  composite << punk
end

composite.save( "./i/quiz_ii.png" )
composite.zoom(2).save( "./i/quiz_ii@2x.png" )
composite.zoom(4).save( "./i/quiz_ii@4x.png" )

