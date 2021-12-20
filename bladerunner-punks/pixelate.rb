
require_relative '../helper'


###############
## 512x512  (24x24)
##   assume 21px per pixel 21x24 = 504 + 8 = 512
##
##  e.g.   24.times {|i| puts "#{(12+i*21+8.0/24.0*i).to_i} => #{i}," }
##
##  note:  in female & male archetypes/punks the nose and mustache and maybe more
##            is using something like half/half pixels
##              (and, thus, is not a true 24x24 format)
##             these "error" you need to fix by hand when "post-processing" or such
##
##              not especially for female eyes not
##           really possible for female to get a true 24x24 format
##                 e.g. 9 pseudo-pixels squeezed inside a space of 8-pixels

PIXEL_OFFSET = {
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


collection = 'bladerunner-punks'
range      =  (0..999)



range.each do |id|
   next if [16,23].include?( id )


    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    # e.g   #1 = 1

    num  =  if m=meta.name.match( /^#(?<num>[0-9]+)$/ )
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


