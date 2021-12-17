
require 'pixelart'


punks = ImageComposite.new( 10, 10, width: 36, height: 36 )   ## 10x10 = 100


collection = 'onlypunksnft'


files = Dir.glob( "./#{collection}/ii/*.png" )
puts "#{files.size} file(s)"


files = files.sort
puts files.inspect

## note: cut-off - only use first hundred
files[0..99].each do |file|
  puts "==> #{file}"
  img = Image.read( file )

  punks << img
end

punks.save( "./i/only.png" )
punks.zoom(2).save( "./i/only@2x.png" )
punks.zoom(4).save( "./i/only@4x.png" )

puts "bye"

