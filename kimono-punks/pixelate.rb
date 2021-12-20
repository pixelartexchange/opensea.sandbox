
require_relative '../helper'


###############
## 512x512  (27x27)
##   assume 18px per pixel 18x27 = 486 + 26 = 512
##
##  e.g.   27.times {|i| puts "#{(9+i*18+26.0/27.0*i).to_i} => #{i}," }

PIXEL_OFFSET = {
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


collection = 'kimono-punks'
range      = (98..128)


range.each do |id|
    next if [61, 86, 110, 125].include?( id )

    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    # e.g KimonoNinjaPunks #001 => 1
    #     KimonoNinjaPunks＃060 => 60
    num  =  if m=meta.name.match( /^KimonoNinjaPunks[ ]*[#＃](?<num>[0-9]+)$/ )
                      m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
            elsif meta.name == 'KimonoNinjaPunks xxxx1'
                      999
            else
                    puts "!! ERROR - cannot find id number in >#{meta.name}<:"
                    pp meta
                    exit 1
                  end

    slug = "%03d" % num

    puts "==> #{id}  - #{meta.name} => #{num} | #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )

    if (img.width == 512 || img.width == 511) && img.height == 512
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end

    pix = img.pixelate( PIXEL_OFFSET )
    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"


