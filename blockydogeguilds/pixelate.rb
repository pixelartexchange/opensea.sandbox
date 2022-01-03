
require_relative '../helper'



collection = 'blockydogeguilds'
range      =  (0..999)   # 1000 items


range.each do |id|

    meta = OpenSea::Meta.read( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    #####
    #  #1 Blocky Doge: Guilds    => 1
    #  #536 Blocky Doge: Guilds => 536
    num =  if m=meta.name.match( /^#(?<num>[0-9]+) Blocky Doge: Guilds$/ )
             m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
           else
              puts "!! ERROR - cannot find id number in >#{meta.name}<:"
              pp meta
              exit 1
           end

     slug = "%04d" % num

     puts "==> #{id}  - #{meta.name} => #{num} | #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )

    if img.width == 512 && img.height == 512
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end

    pix = img.pixelate( Image::PIXEL_OFFSETS[ '512x512']['80x80'] )
    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"


