
require_relative '../helper'



collection = 'the-pixel-portraits-og'
range      =  (449..1004)   # (0..1004)   #  1005 items


slugs = Hash.new(0)

range.each do |id|
  ## filter out - family portraits images and composites:
  ##   no. 21 - is 240x240 (skip for now)
  ##   no. 449 is 15000x15000 hi-def composite
    next if [21, 449].include?( id )

    meta = OpenSea::Meta.read( "./#{collection}/meta/#{id}.json" )

    puts meta.name

    slug = slugify( meta.name )
    slug = 'noname'  if slug.empty?   # note: if name is emoji or such (results in empty string)

    count = slugs[ slug ] += 1   ## note: allow same name twice etc.
    slug << "_(#{count})"    if count > 1

    puts "==> #{id}  - #{meta.name} | #{slug}"

    img = Image.read( "./#{collection}/i/#{id}.png" )

    if img.width == 512 && img.height == 512
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end

    pix = img.pixelate( Image::PIXEL_OFFSETS[ '512x512']['24x24'] )
    pix.save( "./#{collection}/ii/#{slug}.png")
end


puts "bye"


