####
# try to check pixel format and color sampling offsets


require_relative '../artbase'



def calc_pixel_offset( from:, to:, padding_left: 0, padding_top: 0 )

end


###  (100x100)
##      5*100 = 500 + 12 = 512
PIXEL_OFFSET_100 =
    100.times.reduce({}) {|h,i| h[ (5*i+12.0/100.0*i).to_i ] = i; h }

###  (98x98)
##      5*98  = 490 + 22 = 512
PIXEL_OFFSET_98 =
   98.times.reduce({}) {|h,i| h[ (5*i+22.0/98.0*i).to_i ] = i; h }

###  (96x96)
##      5*96  = 480 + 32 = 512
PIXEL_OFFSET_96 =
   96.times.reduce({}) {|h,i| h[ (5*i+32.0/96.0*i).to_i ] = i; h }

PIXEL_OFFSET_94 =
   94.times.reduce({}) {|h,i| h[ (5*i+42.0/94.0*i).to_i ] = i; h }


def sample( img, offset,
              color:  Color.parse( '#ffff00' ),
              top_x: 0,
              top_y: 0)  ## add a yellow pixel

  if img.width == 512 && img.height == 512
    ## do nothing; everything ok
  else
    puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
    exit 1
  end



  offset.each do |offset_x, x|
    offset.each do |offset_y, y|
        base_x = top_x+offset_x
        base_y = top_y+offset_y

        img[base_x,base_y] = color

       ## add more colors
       img[base_x+1,base_y] = color
       img[base_x+2,base_y] = color

       img[base_x,base_y+1] = color
       img[base_x,base_y+2] = color
      end
  end

  img
end




# img = Image.read( "./i/0.png")
# img = sample( img, PIXEL_OFFSET_98 )
# img.save( "./tmp/0_(98).png")

img = Image.read( "./i/1.png")
pix = img.pixelate( PIXEL_OFFSET_98 )
pix.save( "./tmp/1_(98)_pix.png")
img = sample( img, PIXEL_OFFSET_98, top_x: 3, top_y: 1 )
img.save( "./tmp/1_(98_3_1).png")

img = Image.read( "./i/2.png")
pix = img.pixelate( PIXEL_OFFSET_98 )
pix.save( "./tmp/2_(98)_pix.png")
img = sample( img, PIXEL_OFFSET_98, top_x: 3, top_y: 1 )
img.save( "./tmp/2_(98_3_1).png")


__END__

img = Image.read( "./i/1.png")
img = sample( img, PIXEL_OFFSET_96 )
img.save( "./tmp/1_(96).png")

img = Image.read( "./i/2.png")
img = sample( img, PIXEL_OFFSET_96 )
img.save( "./tmp/2_(96).png")


img = Image.read( "./i/1.png")
img = sample( img, PIXEL_OFFSET_94 )
img.save( "./tmp/1_(94).png")


img = Image.read( "./i/1.png")
img = sample( img, PIXEL_OFFSET_100 )
img.save( "./tmp/1_(100).png")

img = Image.read( "./i/2.png")
pix = img.pixelate( PIXEL_OFFSET_100 )
pix.save( "./tmp/2_(100)_pix.png")
img = sample( img, PIXEL_OFFSET_100 )
img.save( "./tmp/2_(100).png")



puts "bye"

