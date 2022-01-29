####
# try to check pixel format and color sampling offsets

$LOAD_PATH.unshift( "../../pixelart/pixelart/lib" )
$LOAD_PATH.unshift( "../../artbase/lib" )

require_relative '../artbase'




def sample( img, steps_x, steps_y=steps_x,
              color:  Color.parse( '#ffff00' ),
              top_x: 0,
              top_y: 0)  ## add a yellow pixel

  ## if img.width == 512 && img.height == 512
  if img.width == 1500 && img.height == 1500
    ## do nothing; everything ok
  else
    puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
    exit 1
  end


  steps_x.each_with_index do |step_x, x|
    steps_y.each_with_index do |step_y, y|
        base_x = top_x+step_x
        base_y = top_y+step_y

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


top_x = 8
steps_x       = Image.calc_sample_steps( 1500-2, 98 )
steps_y       = Image.calc_sample_steps( 1500,   98 )

steps_x_debug = Image.calc_sample_steps( 1500-2, 98, center: false )
steps_y_debug = Image.calc_sample_steps( 1500,   98, center: false )


composite = ImageComposite.new( 2, 2, width: 98,
                                      height: 98 )



img = Image.read( "./token-i/1.png")
pix = img.pixelate( steps_x, steps_y, top_x: top_x )
pix.save( "./tmp/1_(98)_pix.png")
composite << pix

img = sample( img, steps_x_debug, steps_y_debug, top_x: top_x )
# img = sample( img, PIXEL_OFFSET_98, top_x: 3, top_y: 1 )
img.save( "./tmp/1_(98).png")


img = Image.read( "./token-i/2.png")
pix = img.pixelate( steps_x, steps_y, top_x: top_x )
pix.save( "./tmp/2_(98)_pix.png")
composite << pix

img = sample( img, steps_x_debug, steps_y_debug, top_x: top_x )
# img = sample( img, PIXEL_OFFSET_98, top_x: 3, top_y: 1 )
img.save( "./tmp/2_(98).png")



img = Image.read( "./token-i/12.png")
pix = img.pixelate( steps_x, steps_y, top_x: top_x )
pix.save( "./tmp/12_(98)_pix.png")
composite << pix

img = sample( img, steps_x_debug, steps_y_debug, top_x: top_x )
# img = sample( img, PIXEL_OFFSET_98, top_x: 3, top_y: 1 )
img.save( "./tmp/12_(98).png")


img = Image.read( "./token-i/11.png")
pix = img.pixelate( steps_x, steps_y, top_x: top_x )
pix.save( "./tmp/11_(98)_pix.png")
composite << pix

img = sample( img, steps_x_debug, steps_y_debug, top_x: top_x )
# img = sample( img, PIXEL_OFFSET_98, top_x: 3, top_y: 1 )
img.save( "./tmp/11_(98).png")




composite.save( "./tmp/pixies.png" )
composite.zoom( 2 ).save( "./tmp/pixies@2x.png" )



puts "bye"

