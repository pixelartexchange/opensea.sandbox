#############################################
#  generate / create more pixel punk composites


$LOAD_PATH.unshift( "../pixelart/pixelart/lib" )
require 'pixelart'


names = [
  'lorenzo_de_medici',
  'rudolf_clausius',
  'j_r_r_tolkien',
  'michael_stipe',
  'diane_keaton',
  'rowan_atkinson',
  'zora_neale_hurston',
  'stephen_hawking',
  'joan_baez',
  'rod_stewart',
  'mary_j_blige',
  'howard_stern',
]

composite = ImageComposite.new( 4, 3 )

names.each do |name|
  punk = Image.read( "./punkoftheday/ii/#{name}.png" )
  composite << punk.transparent
end


composite.save( "./tmp/punkoftheday.png" )
composite.zoom(2).save( "./tmp/punkoftheday@2x.png" )
composite.zoom(4).save( "./tmp/punkoftheday@4x.png" )
composite.zoom(8).save( "./tmp/punkoftheday@8x.png" )


__END__

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