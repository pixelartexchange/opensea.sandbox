require 'pixelart'

require_relative '../helper'


###############
##  336x336
##
##  14*24 = 336
##
##  use a "safe" offset of 8 pixel
##  e.g.   24.times {|i| puts "#{8+i*14} => #{i}," }

PIXEL_OFFSET = {
  8 => 0,
  22 => 1,
  36 => 2,
  50 => 3,
  64 => 4,
  78 => 5,
  92 => 6,
  106 => 7,
  120 => 8,
  134 => 9,
  148 => 10,
  162 => 11,
  176 => 12,
  190 => 13,
  204 => 14,
  218 => 15,
  232 => 16,
  246 => 17,
  260 => 18,
  274 => 19,
  288 => 20,
  302 => 21,
  316 => 22,
  330 => 23,
}



def pixelate( img )
  dest = Image.new( 24, 24 )

  if img.width == 336 && img.height == 336
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

collection = 'mafia-punks-club'
range      = (0..194)   # 195 items


nums = Hash.new(0)


range.each do |id|

    meta = read_meta( "./#{collection}/meta/#{id}.json" )

    pp meta.name
    ##
    #    e.g.  Mafia Punks Club #1

    num  =  if m=meta.name.match( /^Mafia Punks Club #(?<num>[0-9]+)/ )
                m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
            else
              puts "!! ERROR - cannot find id number in >#{meta.name}<:"
              pp meta
              exit 1
            end


    ## check for duplicate nums and warn

    nums[ num] += 1
    count = nums[ num ]

    slug = if count > 1
              puts "!! WARN - duplicate num #{num} - auto-adding counter #{count}"
              "%03d_(#{count})" % num
           else
             "%03d" % num
           end

    puts "==> #{id}  - #{meta.name} => #{num} | #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )
    puts "     #{img.width}x#{img.height}"
    pix = pixelate( img )

    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"
