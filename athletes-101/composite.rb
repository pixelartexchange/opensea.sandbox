
require 'pixelart'


punks = ImageComposite.new( 6, 6 )   ## 6x6 = 36


collection = 'athletes-101'


files = Dir.glob( "./#{collection}/ii/*.png" )
puts "#{files.size} file(s)"


files = files.sort
puts files.inspect


files.each do |file|
  puts "==> #{file}"
  img = Image.read( file )

  punks << img
end

punks.save( "./i/athletes.png" )
punks.zoom(2).save( "./i/athletes@2x.png" )
punks.zoom(4).save( "./i/athletes@4x.png" )

puts "bye"

