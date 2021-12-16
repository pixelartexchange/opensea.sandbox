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


## quiz no. 1
composite = ImageComposite.new( 3, 3 )

pop_rock.each do |punk|
  composite << punk
end

composite.save( "./i/quiz_i.png" )
composite.zoom(2).save( "./i/quiz_i@2x.png" )
composite.zoom(4).save( "./i/quiz_i@4x.png" )

