

require_relative '../helper'


files = Dir.glob( '../punks.readymade/**/*.png' )


files = files.sort

puts "  #{files.size} file(s)"
#=> 495 file(s)



composite = ImageComposite.new( 25, 20 )   # 25x20 = 500
files.each do |file|
  next if file.index( '/readymades.png' )  ## skip composites
  composite << Image.read( file )
end

rootdir = './misc/tmp'
# rootdir = '../punks.readymade'



composite.save( "#{rootdir}/readymades.png" )

composite.zoom(2).save( "./misc/tmp/readymades@2x.png" )
composite.zoom(6).save( "./misc/tmp/readymades@6x.png" )

puts "bye"
