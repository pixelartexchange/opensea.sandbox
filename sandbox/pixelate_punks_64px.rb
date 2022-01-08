#####
##
##  see https://twitter.com/HighEffortPunks



require_relative '../helper'


###
##  360x360 (64x64)
##
##     assume 5px per pixel - 5 x 64 = 320 + 40 = 360
##
##  eg. 64.times {|i| puts "#{(2+i*5+(40.0/64.0*i)).to_i} => #{i}," }


PIXEL_OFFSET =
{
  2 => 0,
  7 => 1,
  13 => 2,
  18 => 3,
  24 => 4,
  30 => 5,
  35 => 6,
  41 => 7,
  47 => 8,
  52 => 9,
  58 => 10,
  63 => 11,
  69 => 12,
  75 => 13,
  80 => 14,
  86 => 15,
  92 => 16,
  97 => 17,
  103 => 18,
  108 => 19,
  114 => 20,
  120 => 21,
  125 => 22,
  131 => 23,
  137 => 24,
  142 => 25,
  148 => 26,
  153 => 27,
  159 => 28,
  165 => 29,
  170 => 30,
  176 => 31,
  182 => 32,
  187 => 33,
  193 => 34,
  198 => 35,
  204 => 36,
  210 => 37,
  215 => 38,
  221 => 39,
  227 => 40,
  232 => 41,
  238 => 42,
  243 => 43,
  249 => 44,
  255 => 45,
  260 => 46,
  266 => 47,
  272 => 48,
  277 => 49,
  283 => 50,
  288 => 51,
  294 => 52,
  300 => 53,
  305 => 54,
  311 => 55,
  317 => 56,
  322 => 57,
  328 => 58,
  333 => 59,
  339 => 60,
  345 => 61,
  350 => 62,
  356 => 63,
}


range      = (1..6)   # (3..12)   ##(1..2)

range.each do |id|

    slug = "%02d" % id

    img = Image.read( "./sandbox/i/high#{slug}.png" )

    if img.width == 360 && img.height == 360
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end

    pix = img.pixelate( PIXEL_OFFSET )
    pix = pix.transparent( fuzzy: true )
    pix.save( "./sandbox/ii/high#{slug}.png")
end


puts "bye"


