
require_relative '../helper'


###############
## 512x512  (36x36)
##   assume 14px per pixel 14x36 = 504 + 8 = 512
##
##  e.g.   36.times {|i| puts "#{(8+i*14+8.0/36.0*i).to_i} => #{i}," }

PIXEL_OFFSET = {
  8 => 0,
  22 => 1,
  36 => 2,
  50 => 3,
  64 => 4,
  79 => 5,
  93 => 6,
  107 => 7,
  121 => 8,
  136 => 9,
  150 => 10,
  164 => 11,
  178 => 12,
  192 => 13,
  207 => 14,
  221 => 15,
  235 => 16,
  249 => 17,
  264 => 18,
  278 => 19,
  292 => 20,
  306 => 21,
  320 => 22,
  335 => 23,
  349 => 24,
  363 => 25,
  377 => 26,
  392 => 27,
  406 => 28,
  420 => 29,
  434 => 30,
  448 => 31,
  463 => 32,
  477 => 33,
  491 => 34,
  505 => 35,
}


collection = 'dogepunks-collection'
range      = (0..149)   # 150 items



range.each do |id|
    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    # e.g   DogePunk #1 = 1

    num  =  if m=meta.name.match( /^DogePunk #(?<num>[0-9]+)$/ )
                      m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
            else
                    puts "!! ERROR - cannot find id number in >#{meta.name}<:"
                    pp meta
                    exit 1
                  end

    slug = "%03d" % num

    puts "==> #{id}  - #{meta.name} => #{num} | #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )

    if img.width == 512 && img.height == 512
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end

    pix = img.pixelate( PIXEL_OFFSET )
    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"


