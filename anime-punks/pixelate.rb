require 'pixelart'

require_relative '../helper'


###############
## 512x512  (30x30)
##   assume 17px per pixel 17x30 = 510 +2 = 512
##
##  e.g.   30.times {|i| puts "#{10+i*17} => #{i}," }

PIXEL_OFFSET = {
  0 => 0,
  27 => 1,
  44 => 2,
  61 => 3,
  78 => 4,
  95 => 5,
  112 => 6,
  129 => 7,
  146 => 8,
  163 => 9,
  180 => 10,
  197 => 11,
  214 => 12,
  231 => 13,
  248 => 14,
  265 => 15,
  282 => 16,
  299 => 17,
  316 => 18,
  333 => 19,
  350 => 20,
  367 => 21,
  384 => 22,
  401 => 23,
  418 => 24,
  435 => 25,
  452 => 26,
  469 => 27,
  486 => 28,
  503 => 29,
}



def pixelate( img )
  dest = Image.new( 30, 30 )

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


collection = 'anime-punks'
range      = (0..9)  #  (0..974)   # 975 items



range.each do |id|

    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    # e.g    Goku #1           => 1
    #        Kiba Adult #149   => 149

    name, num  =  if m=meta.name.match( /^(?<name>.+) #(?<num>[0-9]+)$/ )
                     [m[:name].strip,
                      m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
                     ]
                  else
                    puts "!! ERROR - cannot find id number in >#{meta.name}<:"
                    pp meta
                    exit 1
                  end

    slug = "%03d" % num
    slug << "-"
    slug << slugify( name )

    puts "==> #{id}  - #{name} => #{num} | #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )
    puts "     #{img.width}x#{img.height}"
    pix = pixelate( img )

    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"


