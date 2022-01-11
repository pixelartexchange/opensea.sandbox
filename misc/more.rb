#############################################
#  generate / create more pixel punk composites


$LOAD_PATH.unshift( "../pixelart/pixelart/lib" )
require 'pixelart'


ids = [
  1434,  # Catherine the Great
  3303,  # Sojourner Truth
  2499,  # Amelia Earhart   ## use Emelia spelling - Why? why not?
  2827,  # Anne Frank
  5270,  # Marilyn Monroe
  2176,  # Paris Hilton
  2656,  # Oprah Winfrey
  5920,  # Billie Eilish
]

composite = ImageComposite.new( 4, 2 )

ids.each do |id|
  punk = Image.read( "./wunks/ii/#{id}.png" )
  composite << punk.transparent
end


composite.save( "./tmp/wunks-icons.png" )
composite.zoom(2).save( "./tmp/wunks-icons@2x.png" )
composite.zoom(4).save( "./tmp/wunks-icons@4x.png" )
composite.zoom(8).save( "./tmp/wunks-icons@8x.png" )



puts "bye"