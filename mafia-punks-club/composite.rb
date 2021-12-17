
require 'pixelart'


punks = ImageComposite.new( 14, 14 )   ## 14x14 = 196

collection = 'mafia-punks-club'


files = Dir.glob( "./#{collection}/ii/*.png" )
puts "#{files.size} file(s)"


files = files.sort
puts files.inspect

files.each do |file|
  puts "==> #{file}"
  img = Image.read( file )

  punks << img
end

punks.save( "./i/mafia.png" )
punks.zoom(2).save( "./i/mafia@2x.png" )
punks.zoom(4).save( "./i/mafia@4x.png" )

puts "bye"

