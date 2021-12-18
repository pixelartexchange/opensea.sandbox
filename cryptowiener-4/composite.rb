
require 'pixelart'


punks = ImageComposite.new( 10, 20, width: 32, height: 32 )   ## 10x20 = 200


collection = 'cryptowiener-4'


files = Dir.glob( "./#{collection}/ii/*.png" )
puts "#{files.size} file(s)"


files = files.sort
puts files.inspect

files.each do |file|
  puts "==> #{file}"
  img = Image.read( file )

  punks << img
end

punks.save( "./i/wiener.png" )
punks.zoom(2).save( "./i/wiener@2x.png" )
punks.zoom(4).save( "./i/wiener@4x.png" )

puts "bye"

