require 'pixelart'


archetypes = [
  'memefur',
  'redfur',
  'sesamefur',
  'blackandtanfur',
  'creamfur',
]

expressions = [
  'standard',
  'laughing',
  'smiley',
  'tongueout',
  'pouty',
  'sleepy',
  'sad',
  'shocked',
]

accessories = [
  'sunglasses',
  'greenpartyhat',
  'greencap',
]


composite = ImageComposite.new( expressions.size, archetypes.size,
                                width: 60,
                                height: 60 )

archetypes.each do |archetype_name|
  base = Image.read( "./attributes/#{archetype_name}.png" )

  expressions.each do |expression_name|
    expression = Image.read( "./attributes/#{expression_name}.png" )
    doge = Image.new( 60, 60 )
    doge.compose!( base )
    doge.compose!( expression )

    doge.save( "./tmp/#{archetype_name}-#{expression_name}.png" )
    doge.zoom(4).save( "./tmp/#{archetype_name}-#{expression_name}@4x.png" )

    composite << doge
  end
end


composite.save( "./tmp/doge.png" )
composite.zoom(2).save( "./tmp/doge@2x.png" )



srand( 4142 )



composite = ImageComposite.new( archetypes.size, accessories.size,
                                width: 60,
                                height: 60,
                                background: '#638596' )

accessories.each do |accessory_name|
  accessory = Image.read( "./attributes/#{accessory_name}.png" )
  archetypes.each do |archetype_name|
    base = Image.read( "./attributes/#{archetype_name}.png" )

    ## pick a random expression
    expression_name = expressions[ rand( expressions.size ) ]
    expression = Image.read( "./attributes/#{expression_name}.png" )


    doge = Image.new( 60, 60 )
    doge.compose!( base )
    doge.compose!( expression )
    doge.compose!( accessory )

    doge.save( "./tmp/#{archetype_name}-#{accessory_name}.png" )
    doge.zoom(4).save( "./tmp/#{archetype_name}-#{accessory_name}@4x.png" )

    composite << doge
  end
end


composite.save( "./tmp/doge_(2).png" )
composite.zoom(2).save( "./tmp/doge_(2)@2x.png" )





puts "bye"