require 'pixelart'

require_relative '../helper'


###############
##  512x512
##
##  assume 16px per pixel and 32x32 dimensions
##     16*32 = 512
##
##  use a "safe" offset of 8 pixel
##
##  e.g.   32.times {|i| puts "#{8+i*16} => #{i}," }
##
##  350x350
##  assume 10px per pixel and 32x32
##     10x32 = 320 + 30
##  use a "safe" offset of 5 pixel
##  e.g.   32.times {|i| puts "#{(5+i*10+30.0/32.0*i).to_i} => #{i}," }


PIXEL_OFFSET_512 = {
  8 => 0,
  24 => 1,
  40 => 2,
  56 => 3,
  72 => 4,
  88 => 5,
  104 => 6,
  120 => 7,
  136 => 8,
  152 => 9,
  168 => 10,
  184 => 11,
  200 => 12,
  216 => 13,
  232 => 14,
  248 => 15,
  264 => 16,
  280 => 17,
  296 => 18,
  312 => 19,
  328 => 20,
  344 => 21,
  360 => 22,
  376 => 23,
  392 => 24,
  408 => 25,
  424 => 26,
  440 => 27,
  456 => 28,
  472 => 29,
  488 => 30,
  504 => 31,
}


PIXEL_OFFSET_350 = {
  5 => 0,
  15 => 1,
  26 => 2,
  37 => 3,
  48 => 4,
  59 => 5,
  70 => 6,
  81 => 7,
  92 => 8,
  103 => 9,
  114 => 10,
  125 => 11,
  136 => 12,
  147 => 13,
  158 => 14,
  169 => 15,
  180 => 16,
  190 => 17,
  201 => 18,
  212 => 19,
  223 => 20,
  234 => 21,
  245 => 22,
  256 => 23,
  267 => 24,
  278 => 25,
  289 => 26,
  300 => 27,
  311 => 28,
  322 => 29,
  333 => 30,
  344 => 31,
}


def pixelate( img )
  dest = Image.new( 32, 32 )


  offset  = if img.width == 512 && (img.height == 512 || img.height == 511 )
               PIXEL_OFFSET_512
            elsif img.width == 350 && img.height == 350
               PIXEL_OFFSET_350
            else
             puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
             exit 1
           end



  offset.each do |offset_x, x|
    offset.each do |offset_y, y|
       pixel = img[offset_x,offset_y]

       dest[x,y] =  pixel
    end
  end

  dest
end

collection = 'cryptowiener-4'
range      = (0..199)   # 200 items


nums = Hash.new(0)

range.each do |id|

    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    pp meta.name

    num = meta.token_id.to_i( 10 )  ## use base 10


    nums[ num ] += 1
    count = nums[ num ]
    slug =  if count > 1
                puts "!! WARN - duplicate num / slug - auto-adding count #{count}"
                "%03d_(#{count})" % num
            else
                '%03d' % num
            end

    puts "==> #{id}  - >#{meta.name}<, #{meta.token_id}  => #{num} | #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )
    puts "     #{img.width}x#{img.height}"
    pix = pixelate( img )

    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"
