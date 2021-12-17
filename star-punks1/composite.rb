
require 'pixelart'


punks = ImageComposite.new( 20, 23, width: 32, height: 32 )   ## 20x23 = 460

collection = 'star-punks1'


files = Dir.glob( "./#{collection}/ii/*.png" )
puts "#{files.size} file(s)"


files = files.sort
puts files.inspect

files.each do |file|
  puts "==> #{file}"
  img = Image.read( file )

  punks << img
end

punks.save( "./i/star.png" )
punks.zoom(2).save( "./i/star@2x.png" )

puts "bye"

