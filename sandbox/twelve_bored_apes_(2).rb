require 'pixelart'


frame = Image.read( "./sandbox/frame_black50x50_(2).png" )

puts "  frame (#{frame.width}x#{frame.height})"
# => 56x56

composite = ImageComposite.new( 4, 3, width: 56+4, height: 56+4 )



(1..12).each do |id|
  slug = '%02d' % id
  frameless = Image.read( "./sandbox/iii/basicape#{slug}.png" )
    puts "==> #{slug} (#{frameless.width}x#{frameless.height})"

  ## add 4px (2p on each side transparent padding/border)
  punk = Image.new( 56+4, 56+4 )
  punk.compose!( frame, 2, 2 )
  punk.compose!( Image.new( 50,50, '#ffffff' ), 3+2, 3+2 )  ## add non-trasparent / opaque background first
  punk.compose!( frameless, 3+2, 3+2 )

  composite << punk
end


composite.save( "./tmp/twelve_bored_apes_(2).png" )
composite.zoom(2).save( "./tmp/twelve_bored_apes_(2)@2x.png" )
composite.zoom(4).save( "./tmp/twelve_bored_apes_(2)@4x.png" )
composite.zoom(8).save( "./tmp/twelve_bored_apes_(2)@8x.png" )

puts "bye"
