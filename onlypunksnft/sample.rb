####
# try to check pixel format and color sampling offsets


require 'pixelart'

require_relative '../helper'


###############
## 450x450
##
##  assume 24x24 extension by top 3 plus bottom 8 (3+24+8 = 35)
##
##  12 * 35 = 420 + 30 = 450
##
## quick hack use safe 4 for pixel offset
##  e.g.   ##  36.times {|i| puts "#{(2+i*12+(18.0/36.0)*i).to_i} => #{i}," }
##             35.times {|i| puts "#{(4+i*12+(30.0/35.0)*i).to_i} => #{i}," }

PIXEL_OFFSET_36 = {
  2 => 0,
  14 => 1,
  27 => 2,
  39 => 3,
  52 => 4,
  64 => 5,
  77 => 6,
  89 => 7,
  102 => 8,
  114 => 9,
  127 => 10,
  139 => 11,
  152 => 12,
  164 => 13,
  177 => 14,
  189 => 15,
  202 => 16,
  214 => 17,
  227 => 18,
  239 => 19,
  252 => 20,
  264 => 21,
  277 => 22,
  289 => 23,
  302 => 24,
  314 => 25,
  327 => 26,
  339 => 27,
  352 => 28,
  364 => 29,
  377 => 30,
  389 => 31,
  402 => 32,
  414 => 33,
  427 => 34,
  439 => 35,
}

PIXEL_OFFSET_35 = {
  4 => 0,
  16 => 1,
  29 => 2,
  42 => 3,
  55 => 4,
  68 => 5,
  81 => 6,
  94 => 7,
  106 => 8,
  119 => 9,
  132 => 10,
  145 => 11,
  158 => 12,
  171 => 13,
  184 => 14,
  196 => 15,
  209 => 16,
  222 => 17,
  235 => 18,
  248 => 19,
  261 => 20,
  274 => 21,
  286 => 22,
  299 => 23,
  312 => 24,
  325 => 25,
  338 => 26,
  351 => 27,
  364 => 28,
  376 => 29,
  389 => 30,
  402 => 31,
  415 => 32,
  428 => 33,
  441 => 34,
}



def sample( img, offset,
              color:  Color.parse( '#ffff00' ))  ## add a yellow pixel

  if img.width == 450 && img.height == 450
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



collection = 'onlypunksnft'


img = Image.read( "./#{collection}/i/1.png")

img = sample( img, PIXEL_OFFSET_36 )
img.save( "./#{collection}/tmp/1_36.png")


puts "bye"

