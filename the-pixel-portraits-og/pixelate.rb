
require_relative '../helper'



collection = 'the-pixel-portraits-og'
range      =  (948..1001)   # (0..1001)   #  1005 items


slugs = Hash.new(0)

range.each do |id|
  ## filter out - family portraits images and composites:
  ##   no. 21 - is 240x240 (skip for now)
  ##   no. 449 is 15000x15000 hi-def composite
  ##   no. 653   is "family" portrait in 512x313
  ##   no. 684   is  512x237
  ##   no. 919   is  512x452
  ##   no. 935    is 512x422
  ##   no. 948    is 512x341
    next if [21, 449, 653, 684, 919, 935, 948].include?( id )

    meta = OpenSea::Meta.read( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    slug = slugify( meta.name )
    slug = 'noname'  if slug.empty?   # note: if name is emoji or such (results in empty string)

    count = slugs[ slug ] += 1   ## note: allow same name twice etc.
    slug << "_(#{count})"    if count > 1

    puts "==> #{id}  - #{meta.name} | #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )

    ##
    # ==> 650  - Cool Cat | cool_cat  511x512

    if [img.width == 511 || img.width == 512] && img.height == 512
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end

    pix = img.pixelate( Image::PIXEL_OFFSETS[ '512x512']['24x24'] )
    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"


