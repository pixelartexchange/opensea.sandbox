
require_relative '../helper'


###############
## 512x512  (24x24)
##   assume 21px per pixel 21x24 = 504 + 8 = 512
##
##  e.g.   24.times {|i| puts "#{(12+i*21+8.0/24.0*i).to_i} => #{i}," }

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


collection = 'youtubepunks'
range      = (0..501)   #  502 items




range.each do |id|
  ####
  # filter out/skip:
  #   no. 155 - cat with hi-res lines / whiskers
  #   no. 252 - hi-res image composite
   next if [155, 252].include?( id )


    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    # e.g. Cody Ko #018      => 18
    #      Guava Juice #491  => 491

    name, num  =  if m=meta.name.match( /^(?<name>.+)[ ]+#(?<num>[0-9]+)$/ )
                     [m[:name].strip,
                      m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
                     ]
                  else
                    puts "!! ERROR - cannot find genius id number:"
                    pp asset
                    exit 1
                  end

    slug = "%03d" % num
    slug << "-"
    slug << slugify( name )

    puts "==> #{id}  - #{name} => #{num} | #{slug}"

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


