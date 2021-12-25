
require_relative '../helper'


###############
## 480x480  (24x24)
##   assume 20px per pixel 20x24 = 480
##
##  e.g.   24.times {|i| puts "#{9+i*20} => #{i}," }

PIXEL_OFFSET = {
  9 => 0,
  29 => 1,
  49 => 2,
  69 => 3,
  89 => 4,
  109 => 5,
  129 => 6,
  149 => 7,
  169 => 8,
  189 => 9,
  209 => 10,
  229 => 11,
  249 => 12,
  269 => 13,
  289 => 14,
  309 => 15,
  329 => 16,
  349 => 17,
  369 => 18,
  389 => 19,
  409 => 20,
  429 => 21,
  449 => 22,
  469 => 23,
}


collection = 'genius-punks'
range      = (0..33)   #  34 items




range.each do |id|
    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    # e.g   Albert Einstein #1
    #       Max Planck #30

   name, num  =  if m=meta.name.match( /^(?<name>.+) #(?<num>[0-9]+)$/ )
                     [m[:name].strip,
                      m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
                     ]
                  else
                    puts "!! ERROR - cannot find id number in >#{meta.name}<:"
                    pp asset
                    exit 1
                  end

    slug = "%03d" % num
    slug << "-"
    slug << slugify( name )

    puts "==> #{id}  - #{name} => #{num} | #{slug}"


    img = Image.read( "./#{collection}/i/#{id}.png" )

    if img.width == 480 && img.height == 480
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end

    pix = img.pixelate( PIXEL_OFFSET )
    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"


