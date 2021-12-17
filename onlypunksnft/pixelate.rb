require 'pixelart'

require_relative '../helper'


###############
## 450x450
##
##  assume 24x24 extension by top 4 plus bottom 8 (4+24+8 = 36)
##
##  12 * 36 = 432 + 18 = 450
##
## quick hack use safe 2 for pixel offset
##  e.g.   ##  36.times {|i| puts "#{(2+i*12+(18.0/36.0)*i).to_i} => #{i}," }
##             35.times {|i| puts "#{(4+i*12+(30.0/35.0)*i).to_i} => #{i}," }

PIXEL_OFFSET = {
    2 => 0,
    14 => 1,
    27 => 2,
    39 => 3,
    52 => 4,
    64 => 5,
    77 => 6,
    89 => 7,
    102 => 8,
    114 => 9,
    127 => 10,
    139 => 11,
    152 => 12,
    164 => 13,
    177 => 14,
    189 => 15,
    202 => 16,
    214 => 17,
    227 => 18,
    239 => 19,
    252 => 20,
    264 => 21,
    277 => 22,
    289 => 23,
    302 => 24,
    314 => 25,
    327 => 26,
    339 => 27,
    352 => 28,
    364 => 29,
    377 => 30,
    389 => 31,
    402 => 32,
    414 => 33,
    427 => 34,
    439 => 35,
  }



def pixelate( img )
  dest = Image.new( 36, 36 )

  if img.width == 450 && img.height == 450
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



collection = 'onlypunksnft'

# range = [30, 31]
range      = (0..199)   # 200 items


range.each do |id|

    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    pp meta.name

    traits = meta.traits
    pp traits



## add to skip custom "verified" gif versions??
## "OnlyPunk #59 (Lana Rhoades)"  -- trait_type >Type< => Verified
## "OnlyPunk #60 (Logan Paul)"   --  trait_type >Type< => Verified
## "OnlyPunk #78 (Belle Delphine)"  -- trait_type >Type< => Verified
## "OnlyPunk #79 (Riley Reid)"      -- trait_type >Type< => Verified
## "OnlyPunk #121 (Mia Khalifa)"     -- trait_type >Type< => Verified
##  "OnlyPunk #133 (Tana Mongeau)"   -- trait_type >Type< => Verified
##  "OnlyPunk #134 (Trisha Paytas)"  -- trait_type >Type< => Verified
##  ..
##
##  check no. 118 - is a zombie but not "typed" ???
##  "OnlyPunk #118" -- trait_type >Type< => Zombies
    trait_type = traits[ 'Type']
    if trait_type && (trait_type['value'] == 'Zombie'  ||
                      trait_type['value'] == 'Zombies' ||
                      trait_type['value'] == 'Ape'     ||
                      trait_type['value'] == 'Alien'
                     )
       puts " !! skipping #{trait_type['value']}"
       next
    end


  ##
  #    e.g.  OnlyPunk #1
  #          OnlyPunk #316
  #
  #  todo/fix - check why this error????
  #   !! ERROR - cannot find id number in >OnlyPunk #316<:
  #    space is unicode  u+00a0 !!


  num  =  if m=meta.name.gsub( "\u{00a0}", ' ').match( /^OnlyPunk #(?<num>[0-9]+)/ )
      m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
  else
    puts "!! ERROR - cannot find id number in >#{meta.name}<:"
    pp meta
    exit 1
  end

    slug = "%03d" % num

    puts "==> #{id}  - #{meta.name} => #{num} | #{slug}"

    gif = "./#{collection}/i/#{id}.gif"
    ## check for gif - and skip for now custon 350x350 images
    if File.exist?( gif )
      puts " !! skipping gif 350x350 custom image"
      next
    end

    img = Image.read( "./#{collection}/i/#{id}.png" )
    puts "     #{img.width}x#{img.height}"
    pix = pixelate( img )

    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"
