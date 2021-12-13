###############################
# to run use:
#    $  ruby histopunks/beethoven.rb


$LOAD_PATH.unshift( "../cryptopunks/cryptopunks/lib" )
require 'cryptopunks'


##############################
# get beethoven (no. 11) from punk, the history edition


beethoven = Image.read( "./histopunks/ii/11.png" )


beethoven.zoom(4).save( "./tmp/beethoven@4x.png" )


HEART_SHADES = Punks::Sheet.find_by( name: 'Heart Shades', gender: 'm' )
HEADBAND     = Punks::Sheet.find_by( name: 'Headband', gender: 'm' )
PIPE         = Punks::Sheet.find_by( name: 'Pipe', gender: 'm' )
CAP_FORWARD  = Punks::Sheet.find_by( name: 'Cap Forward', gender: 'm' )
_3D_GLASSES  = Punks::Sheet.find_by( name: '3D Glasses',  gender: 'm' )
BIRTHDAY_HAT = Punks::Sheet.find_by( name: 'Birthday Hat',  gender: 'm' )
BUBBLE_GUM   = Punks::Sheet.find_by( name: 'Bubble Gum',  gender: 'm' )

NERD_GLASSES       = Punks::Sheet.find_by( name: 'Nerd Glasses',  gender: 'm' )
HORNED_RIM_GLASSES = Punks::Sheet.find_by( name: 'Horned Rim Glasses', gender: 'm' )
VR                 = Punks::Sheet.find_by( name: 'VR', gender: 'm' )

HOODIE             = Punks::Sheet.find_by( name: 'Hoodie', gender: 'm' )
BEANIE             = Punks::Sheet.find_by( name: 'Beanie', gender: 'm' )

EARRING            = Punks::Sheet.find_by( name: 'Earring', gender: 'm' )




composite = ImageComposite.new( 3, 3 )

punk = Image.new( 24, 24 )
punk.compose!( beethoven )

composite << punk


punk = Image.new( 24, 24 )
punk.compose!( beethoven )
punk.compose!( HEART_SHADES )

composite << punk


punk = Image.new( 24, 24 )
punk.compose!( beethoven )
punk.compose!( HEART_SHADES )
punk.compose!( BIRTHDAY_HAT )
punk.compose!( BUBBLE_GUM )

composite << punk


punk = Image.new( 24, 24 )
punk.compose!( beethoven )
punk.compose!( HEADBAND )
punk.compose!( PIPE )

composite << punk

punk = Image.new( 24, 24 )
punk.compose!( beethoven )
punk.compose!( PIPE )
punk.compose!( _3D_GLASSES )
punk.compose!( CAP_FORWARD )

composite << punk


punk = Image.new( 24, 24 )
punk.compose!( beethoven )
punk.compose!( NERD_GLASSES )
punk.compose!( BEANIE )

composite << punk

punk = Image.new( 24, 24 )
punk.compose!( beethoven )
punk.compose!( HORNED_RIM_GLASSES )
punk.compose!( EARRING )

composite << punk

punk = Image.new( 24, 24 )
punk.compose!( beethoven )
punk.compose!( VR )

composite << punk


punk = Image.new( 24, 24 )
punk.compose!( beethoven )
punk.compose!( HOODIE )

composite << punk



composite.save( "./tmp/beethovens.png" )
composite.zoom( 4 ).save( "./tmp/beethovens@4x.png" )
composite.zoom( 8 ).save( "./tmp/beethovens@8x.png" )


puts "bye"
