require 'pixelart'



composite = ImageComposite.new( 3, 2, width: 64, height: 64 )


(1..6).each do |id|
  slug = '%02d' % id

  punk = Image.read( "./sandbox/iii/high#{slug}.png" )

  composite << punk
end


composite.save( "./tmp/punks_64px.png" )
composite.zoom(2).save( "./tmp/punks_64px.@2x.png" )
composite.zoom(4).save( "./tmp/punks_64px.@4x.png" )

puts "bye"
