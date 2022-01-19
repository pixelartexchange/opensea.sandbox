require 'pixelart'



###  male caps
names = [
  'br',
  'brk',
  'castle',
  'dom',
  'dunk',
  'hut',
  'jack',
  'kentucky',
  'sub',
  'w',

  'm-red',
  'm-white',
  'm-gray',
  'm-black',
]

names.each do |name|
  #############
  ## males
  punk = Image.read( "./attributes/m/cap-#{name}.png" )

  cap = punk.crop( 6, 4, 14, 5 )  # x, y, width, height

  cap.zoom(8).save( "./tmp/cap-#{name}_(m)@8x.png")
  cap.mirror.zoom(8).save( "./tmp/cap-#{name}_flipped_(m)@8x.png")


  punk = Image.new( 24, 24 )
  punk.compose!( cap.mirror, 3, 4 )
  punk.save( "./attributes/m/cap-#{name}_flipped.png")

  #########
  ## females
  punk = Image.read( "./attributes/f/cap-#{name}.png" )

  cap = punk.crop( 7, 5, 13, 5 )  # x, y, width, height

  cap.zoom(8).save( "./tmp/cap-#{name}_(f)@8x.png")
  cap.mirror.zoom(8).save( "./tmp/cap-#{name}_flipped_(f)@8x.png")


  punk = Image.new( 24, 24 )
  punk.compose!( cap.mirror, 4, 5 )
  punk.save( "./attributes/f/cap-#{name}_flipped.png")
end



## add a quiz composite

composite = ImageComposite.new( 6, 5, width: 16, height: 7,
                                      background: '#638596' )

names.each do |name|
  punk = Image.read( "./attributes/m/cap-#{name}.png" )

  cap = punk.crop( 6, 4, 14, 5 )  # x, y, width, height

  img = Image.new( 16, 7  )
  img.compose!( cap.mirror, 1, 1 )
  composite << img

  img = Image.new( 16, 7 )
  img.compose!( cap, 1, 1 )
  composite << img
end


composite.save( "./tmp/caps.png" )
composite.zoom( 6 ).save( "./tmp/caps@6x.png" )

puts "bye"

