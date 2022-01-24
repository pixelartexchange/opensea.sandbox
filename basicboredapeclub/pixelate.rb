
require_relative '../artbase'


###############
## 2400x2400  (50x50)
##   assume 48px per pixel 48x50 =  2400
##
##  e.g.   50.times {|i| puts "#{24+i*48} => #{i}," }

PIXEL_OFFSET = {
  24 => 0,
  72 => 1,
  120 => 2,
  168 => 3,
  216 => 4,
  264 => 5,
  312 => 6,
  360 => 7,
  408 => 8,
  456 => 9,
  504 => 10,
  552 => 11,
  600 => 12,
  648 => 13,
  696 => 14,
  744 => 15,
  792 => 16,
  840 => 17,
  888 => 18,
  936 => 19,
  984 => 20,
  1032 => 21,
  1080 => 22,
  1128 => 23,
  1176 => 24,
  1224 => 25,
  1272 => 26,
  1320 => 27,
  1368 => 28,
  1416 => 29,
  1464 => 30,
  1512 => 31,
  1560 => 32,
  1608 => 33,
  1656 => 34,
  1704 => 35,
  1752 => 36,
  1800 => 37,
  1848 => 38,
  1896 => 39,
  1944 => 40,
  1992 => 41,
  2040 => 42,
  2088 => 43,
  2136 => 44,
  2184 => 45,
  2232 => 46,
  2280 => 47,
  2328 => 48,
  2376 => 49,
}


collection = 'basicboredapeclub'
range      =  (38..9999)   #(0..9999)   # 10000 items


range.each do |id|
  slug = "%04d" % id

  print "==> #{id}  - reading / decoding #{slug} ..."
  start = Time.now

  img = Image.read( "./#{collection}/i/#{id}.png" )

  stop = Time.now
  diff = stop - start

  print " in #{diff} sec(s)\n"


  if img.width == 2400 && img.height == 2400
    ## do nothing; everything ok
  else
    puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
    exit 1
  end

  pix = img.pixelate( PIXEL_OFFSET )
  pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"


