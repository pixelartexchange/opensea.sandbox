require 'pixelart'

require_relative '../helper'


###############
## 512x512    21*24 = 504 + 8 = 512
##
##
## quick hack use safe 13 for pixel offset
##  e.g.   24.times {|i| puts "#{i*21+13} => #{i}," }

PIXEL_OFFSET = {
  13  => 0,
  34  => 1,
  55  => 2,
  76  => 3,
  97  => 4,
  118 => 5,
  139 => 6,
  160 => 7,
  181 => 8,
  202 => 9,
  223 => 10,
  244 => 11,
  265 => 12,
  286 => 13,
  307 => 14,
  328 => 15,
  349 => 16,
  370 => 17,
  391 => 18,
  412 => 19,
  433 => 20,
  454 => 21,
  475 => 22,
  496 => 23,
}



def pixelate( img )
  dest = Image.new( 24, 24 )

  ## note: dimension might be off by 1 or 2 pixels e.g.
  ##   510x512 or 512x511 or such !!!!
  if [512,511,510].include?( img.width ) &&
     [512,511].include?( img.height )
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



collection = 'unofficialpunks'
range      = (0..99)   # 100 items


range.each do |id|

    txt = File.open( "./#{collection}/meta/#{id}.json", "r:utf-8") { |f| f.read }
    data = JSON.parse( txt )

    assets = data['assets']
    if assets.size != 1
       puts "!! error - expection one asset per file"
       exit 1
    end

    asset = assets[0]

    name = asset['name']

    traits = asset[ 'traits' ]

    trait_punk_no = traits.select do |t|
                        trait_type = t['trait_type'].strip
                        puts "  trait_type >#{trait_type}< => #{t['value']}"
                        ['Unofficial Punks No.',
                         'Unofficial Punk No.',
                         'Unoffocial Punks No.',
                         'Unoffiical Punks No.'].include?( trait_type )
                    end.first


    ## note: number 58 is used twice!!!!
    num  =  if trait_punk_no
                  trait_punk_no['value'].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
            else
              puts "!! ERROR - cannot find id number:"
              pp traits
              ## pp asset
              exit 1
            end

    slug = "%03d" % num
    slug << "-"
    slug << slugify( name )

    puts "==> #{id}  - #{name} => #{num} | #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )
    puts "     #{img.width}x#{img.height}"
    pix = pixelate( img )

    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"
