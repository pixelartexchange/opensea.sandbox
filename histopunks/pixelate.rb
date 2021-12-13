require 'pixelart'


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

  if img.width == 512 && img.height == 512
    ## do nothing; everything ok
  else
    puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
    exit 1
  end


  ## use pixel[0,0] for background - why? why not?
  background = img[0,0]


  PIXEL_OFFSET.each do |offset_x, x|
    PIXEL_OFFSET.each do |offset_y, y|
       pixel = img[offset_x,offset_y]

        if pixel == background
         dest[x,y] = 0  ## Color::TRANSPARENT
       else
         dest[x,y] =  pixel
       end
    end
  end

  dest
end



collection = 'histopunks'
range      = (0..147)   # 148 items


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

    # e.g.  HistoPunk 1 - Vincent van Gogh  => 1

    num  =  if m=name.match( /^HistoPunk (?<num>[0-9]+) -/ )
                  m[:num].to_i( 10 )   ## note: add base 10 (e.g. 015=>15)
            else
              puts "!! ERROR - cannot find id number:"
              pp asset
              exit 1
            end

    puts "==> #{id}  - #{name} => #{num}"

    img = Image.read( "./#{collection}/i/#{id}.png" )
    puts "     #{img.width}x#{img.height}"
    pix = pixelate( img )

    pix.save( "./#{collection}/ii/#{num}.png")
end


puts "bye"
