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
        '24x24' => {
## 512x512  (24x24)
##   assume 21px per pixel 21x24 = 504 + 8 = 512
##
##  e.g.   24.times {|i| puts "#{(12+i*21+8.0/24.0*i).to_i} => #{i}," }
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
     }
  }
}

end   # class ImageComposite
end   # module Pixelart


