
require_relative '../helper'


###############
## 336x336  (24x24)
##   assume 14px per pixel 24x24 = 336
##
##  e.g.   24.times {|i| puts "#{7+i*14} => #{i}," }

PIXEL_OFFSET = {
  7 => 0,
  21 => 1,
  35 => 2,
  49 => 3,
  63 => 4,
  77 => 5,
  91 => 6,
  105 => 7,
  119 => 8,
  133 => 9,
  147 => 10,
  161 => 11,
  175 => 12,
  189 => 13,
  203 => 14,
  217 => 15,
  231 => 16,
  245 => 17,
  259 => 18,
  273 => 19,
  287 => 20,
  301 => 21,
  315 => 22,
  329 => 23,
}


collection = 'clout-punks'
range      =  (450..499)



range.each do |id|
  ## filter out:
  ##   no. 498 is a hi-res composite
    next if [498].include?(id )

    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    # e.g   6ix9ine Clout Punk

    name  =  meta.name.downcase.sub( 'clout punk', '' ).strip

    slug = slugify( name )

    puts "==> #{id}  - #{meta.name} => #{name} | #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )

    if img.width == 336 && img.height == 336
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end

    pix = img.pixelate( PIXEL_OFFSET )
    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"


