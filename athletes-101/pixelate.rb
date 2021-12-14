require 'pixelart'

require_relative '../helper'


###############
##  423x512  - cut-off bottom meta info text footer
##
## 423x423    17*24 = 408 + 15 = 423
##
##  use a "safe" offset of 10 pixel
##   - add "progressive" extra offset of 15.0/24.0*i to ever pixel
##
## quick hack use
##  e.g.   24.times {|i| puts "#{(10+i*17.0+i*15.0/24.0).to_i} => #{i}," }

PIXEL_OFFSET = {
  10 => 0,
  27 => 1,
  45 => 2,
  62 => 3,
  80 => 4,
  98 => 5,
  115 => 6,
  133 => 7,
  151 => 8,
  168 => 9,
  186 => 10,
  203 => 11,
  221 => 12,
  239 => 13,
  256 => 14,
  274 => 15,
  292 => 16,
  309 => 17,
  327 => 18,
  344 => 19,
  362 => 20,
  380 => 21,
  397 => 22,
  415 => 23,
}



def pixelate( img )
  dest = Image.new( 24, 24 )

  if img.width == 423 && img.height == 512
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

collection = 'athletes-101'
range      = (0..34)   # 35 items



range.each do |id|

    txt = File.open( "./#{collection}/meta/#{id}.json", "r:utf-8") { |f| f.read }
    data = JSON.parse( txt )

    assets = data['assets']
    if assets.size != 1
       puts "!! error - expection one asset per file"
       exit 1
    end

    asset      = assets[0]
    asset_name = asset['name']
    puts asset_name

    ##
    #    e.g.  Athlete #03

    num  =  if m=asset_name.match( /^Athlete #(?<num>[0-9]+)/ )
                m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
            else
              puts "!! ERROR - cannot find id number:"
              pp asset
              exit 1
            end

    slug = "%03d" % num

    puts "==> #{id}  - #{asset_name} => #{num} | #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )
    puts "     #{img.width}x#{img.height}"
    pix = pixelate( img )

    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"
