require 'pixelart'


punk = Image.read( 'sandbox/greta_thunberg.png' )


img = Image.new( 24, 24, '#1E7342' )
img.compose!( punk )

img.save( "sandbox/greta_thunberg_(green).png" )
img.zoom(4).save( "sandbox/greta_thunberg_(green)@4x.png" )
img.zoom(8).save( "sandbox/greta_thunberg_(green)@8x.png" )

puts "bye"

