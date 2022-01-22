require 'pixelart'


files = Dir.glob( "./ii/*.png" )
puts "  #{files.size} file(s)"
#=> 100 file(s)


files.each do |file|
  extname  = File.extname( file )
  basename = File.basename( file, extname )

  img = Image.read( file )

  img = img.transparent
  img.save( "./ii-transparent/#{basename}#{extname}" )

  ## change "white-ish"  in cream fur to yellow
  img = img.change_colors( { "#FBF1EA" => "#FFFF00" } )
  img.save( "./ii-transparent/#{basename}_(2)#{extname}" )
end


puts "bye"