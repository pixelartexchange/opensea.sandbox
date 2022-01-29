####
# try to check pixel format and color sampling offsets

$LOAD_PATH.unshift( "../../pixelart/pixelart/lib" )
$LOAD_PATH.unshift( "../../artbase/lib" )

require_relative '../artbase'



composite = ImageComposite.new( 10, 10, width: 98,
                                      height: 98 )


(0..99).each do |id|
  slug = '%04d' % id

  img = Image.read( "./ii/#{slug}.png")
  composite << img
end

composite.save( "./tmp/pixies_100.png" )
composite.zoom( 2 ).save( "./tmp/pixies_100@2x.png" )


puts "bye"



