####
# try to check pixel format and color sampling offsets


require_relative '../helper'


###############
## 512x512  (27x27)
##   assume 18px per pixel 18x27 = 486 + 26 = 512
##
##  e.g.   27.times {|i| puts "#{(9+i*18+26.0/27.0*i).to_i} => #{i}," }

PIXEL_OFFSET_27 = {
  9 => 0,
  27 => 1,
  46 => 2,
  65 => 3,
  84 => 4,
  103 => 5,
  122 => 6,
  141 => 7,
  160 => 8,
  179 => 9,
  198 => 10,
  217 => 11,
  236 => 12,
  255 => 13,
  274 => 14,
  293 => 15,
  312 => 16,
  331 => 17,
  350 => 18,
  369 => 19,
  388 => 20,
  407 => 21,
  426 => 22,
  445 => 23,
  464 => 24,
  483 => 25,
  502 => 26,
}


## 512x512  (28x28)
##   assume 18px per pixel 18x28 = 504 + 8 = 512
##
##  e.g.   28.times {|i| puts "#{(9+i*18+8.0/28.0*i).to_i} => #{i}," }

PIXEL_OFFSET_28 = {
  9 => 0,
  27 => 1,
  45 => 2,
  63 => 3,
  82 => 4,
  100 => 5,
  118 => 6,
  137 => 7,
  155 => 8,
  173 => 9,
  191 => 10,
  210 => 11,
  228 => 12,
  246 => 13,
  265 => 14,
  283 => 15,
  301 => 16,
  319 => 17,
  338 => 18,
  356 => 19,
  374 => 20,
  393 => 21,
  411 => 22,
  429 => 23,
  447 => 24,
  466 => 25,
  484 => 26,
  502 => 27,
}





def sample( img, offset,
              color:  Color.parse( '#ffff00' ))  ## add a yellow pixel

  if img.width == 512 && img.height == 512
    ## do nothing; everything ok
  else
    puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
    exit 1
  end



  offset.each do |offset_x, x|
    offset.each do |offset_y, y|
       img[offset_x,offset_y] = color
    end
  end

  img
end



collection = 'kimono-punks'


img = Image.read( "./#{collection}/i/0.png")
img = sample( img, PIXEL_OFFSET_28 )
img.save( "./#{collection}/tmp/0_(28).png")

img = Image.read( "./#{collection}/i/0.png")
img = sample( img, PIXEL_OFFSET_27 )
img.save( "./#{collection}/tmp/0_(27).png")

puts "bye"

