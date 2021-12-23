require_relative '../helper'


###############
## 336x336 (34x34)
##   assume 10px per pixel 10*34 = 340-4 = 336
##
##  e.g.   34.times {|i| puts "#{(4+i*10-(4.0/34.4*i)).to_i} => #{i}," }

PIXEL_OFFSET = {
  4 => 0,
  13 => 1,
  23 => 2,
  33 => 3,
  43 => 4,
  53 => 5,
  63 => 6,
  73 => 7,
  83 => 8,
  92 => 9,
  102 => 10,
  112 => 11,
  122 => 12,
  132 => 13,
  142 => 14,
  152 => 15,
  162 => 16,
  172 => 17,
  181 => 18,
  191 => 19,
  201 => 20,
  211 => 21,
  221 => 22,
  231 => 23,
  241 => 24,
  251 => 25,
  260 => 26,
  270 => 27,
  280 => 28,
  290 => 29,
  300 => 30,
  310 => 31,
  320 => 32,
  330 => 33,
}



collection = 'monkepunks'
range      = (0..998)   # 999 items


range.each do |id|

    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    # e.g  MonkePunk #1 => 1

    num  =  if m=meta.name.match( /^MonkePunk #(?<num>[0-9]+)$/ )
                      m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
                  else
                    puts "!! ERROR - cannot find id number in >#{meta.name}<:"
                    pp meta
                    exit 1
                  end

    slug = "%03d" % num

    puts "==> #{id}  - #{meta.name} => #{num} | #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )

    if img.width == 336 && img.height == 336
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end


    pix = pixelate( img, PIXEL_OFFSET )

    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"



