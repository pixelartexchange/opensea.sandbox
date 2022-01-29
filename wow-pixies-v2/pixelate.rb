
$LOAD_PATH.unshift( "../../pixelart/pixelart/lib" )
$LOAD_PATH.unshift( "../../artbase/lib" )

require_relative '../artbase'



top_x = 8
steps_x       = Image.calc_sample_steps( 1500-2, 98 )
steps_y       = Image.calc_sample_steps( 1500,   98 )


range = (44..5554)   # 5555 items
range.each do |id|

  puts "==> #{id}  - reading / decoding #{id} ..."
  start = Time.now

  slug = "%04d" % id
  img = Image.read( "./token-i/#{id}.png" )

  stop = Time.now
  diff = stop - start

  puts "  in #{diff} sec(s)\n"

  if img.width == 1500 && img.height == 1500
    pix = img.pixelate( steps_x, steps_y, top_x: top_x )

    pix.save( "./ii/#{slug}.png")
  else
    puts "!! ERROR - unknown/unsupported dimension - #{img.width}x#{img.height}; sorry"
    exit 1
  end
end

puts "bye"