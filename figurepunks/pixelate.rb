
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



collection = 'figurepunks'
range      =  (0..430)   # 431 items



range.each do |id|
    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    puts meta.name
    puts meta.description

    # name:
    # e.g.  Figure Punks 001   => 1
    #       Figure Punks 041   => 41
    #       Figure Punks 377   => 377
    # description:
    # e.g.   GoR
    #         It's not Jesus
    #         It's not Forest Whitaker


    num  =  if m=meta.name.match( /^Figure Punks (?<num>[0-9]+)$/ )
                      m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
            elsif meta.name.index( 'Figure Punks' )  ## assume missing id
                      999
            else
                    puts "!! ERROR - cannot find id number in >#{meta.name}<:"
                    pp meta
                    exit 1
                  end

    name = meta.description.sub( "It's not", '' ).strip
    name = name[0,42]   # note: limit to first 42 chars


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


