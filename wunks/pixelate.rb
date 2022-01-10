require_relative '../helper'


######################
#  480x480  (24x24)
#    assume 20px per pixel 20x24 = 480
#
#   e.g.   24.times {|i| puts "#{9+i*20} => #{i}," }
PIXEL_OFFSET = {
  9 => 0,
  29 => 1,
  49 => 2,
  69 => 3,
  89 => 4,
  109 => 5,
  129 => 6,
  149 => 7,
  169 => 8,
  189 => 9,
  209 => 10,
  229 => 11,
  249 => 12,
  269 => 13,
  289 => 14,
  309 => 15,
  329 => 16,
  349 => 17,
  369 => 18,
  389 => 19,
  409 => 20,
  429 => 21,
  449 => 22,
  469 => 23,
}



collection = 'wunks'
range      =  (0..5999)   # 6000 items


range.each do |id|

     slug = "%04d" % id

     puts "==> #{id}  | #{slug}"

    img = Image.read( "./#{collection}/token-i/#{id}.png" )

    if img.width == 480 && img.height == 480
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end

    pix = img.pixelate( PIXEL_OFFSET )
    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"

