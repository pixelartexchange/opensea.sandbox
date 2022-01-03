
require_relative '../helper'



collection = 'blockydoge'
range      =  (0..99)   # 100 items


range.each do |id|

    meta = OpenSea::Meta.read( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    #####
    #  Blocky Doge #1  => 1
    num =  if m=meta.name.match( /^Blocky Doge #(?<num>[0-9]+)$/ )
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

    pix = img.pixelate( Image::PIXEL_OFFSETS[ '512x512']['60x60'] )
    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"


