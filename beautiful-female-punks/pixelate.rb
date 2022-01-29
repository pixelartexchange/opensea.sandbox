
$LOAD_PATH.unshift( "../../pixelart/pixelart/lib" )
$LOAD_PATH.unshift( "../../artbase/lib" )

require_relative '../artbase'


px = 28
py = 27

steps_x   = Image.calc_sample_steps( 233, px )
steps_y   = Image.calc_sample_steps( 233, py )

steps_x_debug   = Image.calc_sample_steps( 233, px, center: false )
steps_y_debug   = Image.calc_sample_steps( 233, py, center: false )


# in 24x24 - OK - 16, 17, 18, 19, 20
#
# in ???? -
# in ????  -  22 ??, 23 ??,

ids = [
  2, 3, 4, 5, 6,
  16, 17, 18, 19, 20,
  22, 23
]

ids.each do |id|

  puts "==> #{id}  - reading / decoding #{id} ..."

  slug = "%06d" % id
  img = Image.read( "./page-i/#{id}.png" )

  if img.width == 233 && img.height == 233
    pix = img.pixelate( steps_x, steps_y )

    pix.save( "./ii/#{slug}_#{px}x#{py}.png")


    img = img.pixelate_debug( steps_x_debug, steps_y_debug )
    img.save( "./ii/#{slug}_#{px}x#{py}_(2).png" )
  else
    puts "!! ERROR - unknown/unsupported dimension - #{img.width}x#{img.height}; sorry"
    exit 1
  end
end



steps_x   = Image.calc_sample_steps( 600, px )
steps_y   = Image.calc_sample_steps( 600, py )

steps_x_debug   = Image.calc_sample_steps( 600, px, center: false )
steps_y_debug   = Image.calc_sample_steps( 600, py, center: false )


ids = [
  22
]

ids.each do |id|

  puts "==> #{id}  - reading / decoding #{id} ..."

  slug = "%06d" % id
  img = Image.read( "./page-i_(2)/#{id}.png" )

  if img.width == 600 && img.height == 600
    pix = img.pixelate( steps_x, steps_y )

    pix.save( "./ii_(2)/#{slug}_#{px}x#{py}.png")


    img = img.pixelate_debug( steps_x_debug, steps_y_debug )
    img.save( "./ii_(2)/#{slug}_#{px}x#{py}_(2).png" )
  else
    puts "!! ERROR - unknown/unsupported dimension - #{img.width}x#{img.height}; sorry"
    exit 1
  end
end



puts "bye"