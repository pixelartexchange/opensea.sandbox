
require 'pixelart'


punks = ImageComposite.new( 10, 15 )   ## 10x15 = 150


collection = 'histopunks'


files = Dir.glob( "./#{collection}/ii/*.png" )
puts "#{files.size} file(s)"


ids = files.map { |file| File.basename(file,'.*').to_i }
ids = ids.sort
puts ids.inspect


ids.each do |id|
  puts "==> #{id}"
  img = Image.read( "./#{collection}/ii/#{id}.png" )

  punks << img
end

punks.save( "./i/history.png" )
punks.zoom(2).save( "./i/history@2x.png" )
punks.zoom(4).save( "./i/history@4x.png" )

puts "bye"

