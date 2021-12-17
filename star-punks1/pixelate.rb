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

PIXEL_OFFSET = {
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



def pixelate( img )
  dest = Image.new( 32, 32 )

  if img.width == 512 && img.height == 512
    ## do nothing; everything ok
  else
    puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
    exit 1
  end



  PIXEL_OFFSET.each do |offset_x, x|
    PIXEL_OFFSET.each do |offset_y, y|
       pixel = img[offset_x,offset_y]

       dest[x,y] =  pixel
    end
  end

  dest
end

collection = 'star-punks1'
range      = (0..441)   # 442 items


keys = Hash.new(0)

range.each do |id|

    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    pp meta.name

    ##
    #  note: remove nft from name if present
    key = slugify( meta.name.downcase.gsub('nft', '' ).strip )

    keys[ key ] += 1
    count = keys[ key ]
    slug =  if count > 1
                puts "!! WARN - duplicate key / slug - auto-adding count #{count}"
                "#{key}_(#{count})"
            else
                key
            end

    puts "==> #{id}  - #{meta.name} => #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )
    puts "     #{img.width}x#{img.height}"
    pix = pixelate( img )

    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"
