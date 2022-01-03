######################
#  pixelart image extensions
#    move upstream!!!!!


module Pixelart

class Image


  def sample( offsets )
    ## note: for now always assume square image (e.g. 24x24, 32x32 and such)
    width = height = offsets.size

    puts "     #{self.width}x#{self.height} => #{width}x#{height}"


    dest = Image.new( width, height )

    offsets.each do |offset_x, x|
      offsets.each do |offset_y, y|
         pixel = self[offset_x,offset_y]

         dest[x,y] =  pixel
      end
    end

    dest
  end
  alias_method :pixelate, :sample
end  # class Image



class ImageComposite


def add_glob( glob )
  files = Dir.glob( glob )
  puts "#{files.size} file(s) found matching >#{glob}<"


  files = files.sort
  ## puts files.inspect

  files.each_with_index do |file,i|
     puts "==> [#{i+1}/#{files.size}] - #{file}"
     img = Image.read( file )

     self << img    ## todo/check: use add alias - why? why not?
  end
end

end   # class ImageComposite
end   # module Pixelart




###
#   add common
#     pixel(ate) offsets (for sampling)
module Pixelart
  class Image

PIXEL_OFFSETS = {
   '512x512' =>  {
######################
#  512x512  (24x24)
#    assume 21px per pixel 21x24 = 504 + 8 = 512
#
#   e.g.   24.times {|i| puts "#{(12+i*21+8.0/24.0*i).to_i} => #{i}," }
'24x24' => {
  12 => 0,
  33 => 1,
  54 => 2,
  76 => 3,
  97 => 4,
  118 => 5,
  140 => 6,
  161 => 7,
  182 => 8,
  204 => 9,
  225 => 10,
  246 => 11,
  268 => 12,
  289 => 13,
  310 => 14,
  332 => 15,
  353 => 16,
  374 => 17,
  396 => 18,
  417 => 19,
  438 => 20,
  460 => 21,
  481 => 22,
  502 => 23,
     },

###########
#   512x512 (60x60)
#    assume 8px    60*8 = 480  + 32 = 512
#
#  e.g. 60.times {|i| puts "#{(4+i*8+32.0/60.0*i).to_i} => #{i}," }
  '60x60' => {
  4 => 0,
  12 => 1,
  21 => 2,
  29 => 3,
  38 => 4,
  46 => 5,
  55 => 6,
  63 => 7,
  72 => 8,
  80 => 9,
  89 => 10,
  97 => 11,
  106 => 12,
  114 => 13,
  123 => 14,
  132 => 15,
  140 => 16,
  149 => 17,
  157 => 18,
  166 => 19,
  174 => 20,
  183 => 21,
  191 => 22,
  200 => 23,
  208 => 24,
  217 => 25,
  225 => 26,
  234 => 27,
  242 => 28,
  251 => 29,
  260 => 30,
  268 => 31,
  277 => 32,
  285 => 33,
  294 => 34,
  302 => 35,
  311 => 36,
  319 => 37,
  328 => 38,
  336 => 39,
  345 => 40,
  353 => 41,
  362 => 42,
  370 => 43,
  379 => 44,
  388 => 45,
  396 => 46,
  405 => 47,
  413 => 48,
  422 => 49,
  430 => 50,
  439 => 51,
  447 => 52,
  456 => 53,
  464 => 54,
  473 => 55,
  481 => 56,
  490 => 57,
  498 => 58,
  507 => 59,
},
###########
#   512x512 (80x80)
#    assume 6px    80*6 = 480  + 32 = 512
#
#  e.g. 80.times {|i| puts "#{(3+i*6+32.0/80.0*i).to_i} => #{i}," }
  '80x80' => {
    3 => 0,
    9 => 1,
    15 => 2,
    22 => 3,
    28 => 4,
    35 => 5,
    41 => 6,
    47 => 7,
    54 => 8,
    60 => 9,
    67 => 10,
    73 => 11,
    79 => 12,
    86 => 13,
    92 => 14,
    99 => 15,
    105 => 16,
    111 => 17,
    118 => 18,
    124 => 19,
    131 => 20,
    137 => 21,
    143 => 22,
    150 => 23,
    156 => 24,
    163 => 25,
    169 => 26,
    175 => 27,
    182 => 28,
    188 => 29,
    195 => 30,
    201 => 31,
    207 => 32,
    214 => 33,
    220 => 34,
    227 => 35,
    233 => 36,
    239 => 37,
    246 => 38,
    252 => 39,
    259 => 40,
    265 => 41,
    271 => 42,
    278 => 43,
    284 => 44,
    291 => 45,
    297 => 46,
    303 => 47,
    310 => 48,
    316 => 49,
    323 => 50,
    329 => 51,
    335 => 52,
    342 => 53,
    348 => 54,
    355 => 55,
    361 => 56,
    367 => 57,
    374 => 58,
    380 => 59,
    387 => 60,
    393 => 61,
    399 => 62,
    406 => 63,
    412 => 64,
    419 => 65,
    425 => 66,
    431 => 67,
    438 => 68,
    444 => 69,
    451 => 70,
    457 => 71,
    463 => 72,
    470 => 73,
    476 => 74,
    483 => 75,
    489 => 76,
    495 => 77,
    502 => 78,
    508 => 79,
  }
}
}

end   # class ImageComposite
end   # module Pixelart


