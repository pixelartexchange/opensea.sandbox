
require_relative '../helper'


##
## bored (punk) apes
##   see https://www.boredapesandpunks.com/



###
##  111x111 (24x24)
##
##     assume 4px per pixel - 4 x 24 = 96 + 15 = 111
##
##  eg. 24.times {|i| puts "#{(2+i*4+(15.0/24.0*i)).to_i} => #{i}," }


PIXEL_OFFSET =
{
  2 => 0,
  6 => 1,
  11 => 2,
  15 => 3,
  20 => 4,
  25 => 5,
  29 => 6,
  34 => 7,
  39 => 8,
  43 => 9,
  48 => 10,
  52 => 11,
  57 => 12,
  62 => 13,
  66 => 14,
  71 => 15,
  76 => 16,
  80 => 17,
  85 => 18,
  89 => 19,
  94 => 20,
  99 => 21,
  103 => 22,
  108 => 23,
}


range      = (3..12)   ##(1..2)

range.each do |id|

    slug = "%02d" % id

    img = Image.read( "./sandbox/i/ape#{slug}.png" )

    if img.width == 111 && img.height == 111
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end

    pix = img.pixelate( PIXEL_OFFSET )
    pix = pix.transparent( fuzzy: true )
    pix.save( "./sandbox/ii/boredape#{slug}.png")
end


puts "bye"


