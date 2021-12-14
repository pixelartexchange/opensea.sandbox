
require 'pixelart'


punks = ImageComposite.new( 10, 10 )   ## 10x10 = 100


collection = 'unofficialpunks'


files = Dir.glob( "./#{collection}/ii/*.png" )
puts "#{files.size} file(s)"


files = files.sort
puts files.inspect


files.each do |file|
  puts "==> #{file}"
  img = Image.read( file )

  punks << img
end

punks.save( "./i/unofficial.png" )
punks.zoom(2).save( "./i/unofficial@2x.png" )
punks.zoom(4).save( "./i/unofficial@4x.png" )

puts "bye"

