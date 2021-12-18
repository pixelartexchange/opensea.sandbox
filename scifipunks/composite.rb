
require 'pixelart'


punks = ImageComposite.new( 10, 10 )   ## 10x10 = 100


collection = 'scifipunks'


files = Dir.glob( "./#{collection}/ii/*.png" )
puts "#{files.size} file(s)"


files = files.sort
puts files.inspect

files.each do |file|
  puts "==> #{file}"
  img = Image.read( file )

  punks << img
end

punks.save( "./i/scifi.png" )
punks.zoom(2).save( "./i/scifi@2x.png" )
punks.zoom(4).save( "./i/scifi@4x.png" )

puts "bye"

