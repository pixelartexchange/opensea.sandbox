require 'pixelart'


frame = Image.read( "./sandbox/frame_black24x24_(2).png" )

puts "  frame (#{frame.width}x#{frame.height})"
# => 30x30


composite = ImageComposite.new( 4, 3, width: 30+4, height: 30+4 )



(1..12).each do |id|
  slug = '%02d' % id
  frameless = Image.read( "./sandbox/iii/boredape#{slug}.png" )
    puts "==> #{slug} (#{frameless.width}x#{frameless.height})"

  ## add 4px (2p on each side transparent padding/border)
  punk = Image.new( 30+4, 30+4 )
  punk.compose!( frame, 2, 2 )
  punk.compose!( Image.new( 24,24, '#ffffff' ), 3+2, 3+2 )  ## add non-trasparent / opaque background first
  punk.compose!( frameless, 3+2, 3+2 )

  composite << punk
end


composite.save( "./tmp/twelve_bored_apes.png" )
composite.zoom(2).save( "./tmp/twelve_bored_apes@2x.png" )
composite.zoom(4).save( "./tmp/twelve_bored_apes@4x.png" )
composite.zoom(8).save( "./tmp/twelve_bored_apes@8x.png" )


puts "bye"
