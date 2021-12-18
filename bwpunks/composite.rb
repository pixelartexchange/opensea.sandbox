
require 'pixelart'


punks = ImageComposite.new( 10, 15 )   ## 10x15 = 150


collection = 'bwpunks'


files = Dir.glob( "./#{collection}/ii/*.png" )
puts "#{files.size} file(s)"


files = files.sort
puts files.inspect

files.each do |file|
  puts "==> #{file}"
  img = Image.read( file )

  punks << img
end

punks.save( "./i/bw.png" )
punks.zoom(2).save( "./i/bw@2x.png" )
punks.zoom(4).save( "./i/bw@4x.png" )

puts "bye"

