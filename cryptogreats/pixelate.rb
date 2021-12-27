
require_relative '../helper'


###############
## 512x512  (32x32)
##   assume 16px per pixel 16x32 = 512
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


collection = 'cryptogreats'
range      =   (645..817) # (0..817)   #  818 items



range.each do |id|
  ## filter out - hi-res images and composites:
  ##   no. 100 is a composite
  ##   no.   is a hi-res images
    next if [100,101,102,201,301,403,504,605,804,808].include?(id )

    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    # e.g   Michael Jordan — CryptoGreats #1
    #       Usain Bolt - CryptoGreats #64
    #       Derek Jeter — CryptoPunks #74
    #       CryptoGreats — Dennis Rodman #81
    #       Justin Herbert – CryptoGreats #642

    ## todo/fix: unify dashes (—–-) first to ascii
    ##   move upstream - why? why not?

   name, num  =  if m=meta.name.match( /^(?<name>.+) [—–-] Crypto(Greats|Punks) #(?<num>[0-9]+)$/ )
                     [m[:name].strip,
                      m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
                     ]
                  elsif m=meta.name.match( /^Crypto(Greats|Punks) [—–-] (?<name>.+) #(?<num>[0-9]+)$/ )
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

    if (img.width == 511 || img.width == 512) && img.height == 512
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end

    pix = img.pixelate( PIXEL_OFFSET )
    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"


