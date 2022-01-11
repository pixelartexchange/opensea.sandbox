
require_relative '../helper'


collection = 'wunks'



###
## try a transparent background version
punks = ImageComposite.new( 100, 60 )  # 100x60 = 6000



#  note: change (cigg) cigarette smoke to "classic" color with alpha channel
#
#   COLOR 40 - #dedede / rgb(222 222 222) - hsl( 0° 0% 87%) - α( 50%) - 6 pixels of cigarette smoke (f/m)
color_map = {
  Color.parse( '#f3dae5' ) => Color.parse( '#dedede80' ),
}

files = Dir.glob( "./#{collection}/ii/*.png"  )
files = files.sort


files.each do |file|
  punk = Image.read( file )
  punk = punk.transparent.change_colors( color_map )

  punks << punk
end


punks.save( "./tmp/womenpunks.png" )

puts "bye"

