require 'pixelart'


punk = Image.read( 'viennacrypto-24x24.png')


punk.zoom(8).save( 'viennacrypto-24x24@8x.png' )

puts "bye"