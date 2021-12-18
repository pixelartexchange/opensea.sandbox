require 'pixelart'

require_relative '../helper'


###############
## 240x240
##   assume 10px per pixel 10+24 = 240
##
##  e.g.   24.times {|i| puts "#{4+i*10} => #{i}," }

PIXEL_OFFSET = {
  4 => 0,
  14 => 1,
  24 => 2,
  34 => 3,
  44 => 4,
  54 => 5,
  64 => 6,
  74 => 7,
  84 => 8,
  94 => 9,
  104 => 10,
  114 => 11,
  124 => 12,
  134 => 13,
  144 => 14,
  154 => 15,
  164 => 16,
  174 => 17,
  184 => 18,
  194 => 19,
  204 => 20,
  214 => 21,
  224 => 22,
  234 => 23,
}



def pixelate( img )
  dest = Image.new( 24, 24 )

  if img.width == 240 && img.height == 240
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



collection = 'bwpunks'
range      = (0..149)   # 150 items


range.each do |id|

    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    # e.g    #1 - vanila punk   => 1
    #        #150 - hairless harry punk => 150

    name, num  =  if m=meta.name.match( /^#(?<num>[0-9]+) - (?<name>.+)$/ )
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



