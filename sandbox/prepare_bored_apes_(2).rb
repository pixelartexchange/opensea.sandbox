
require_relative '../helper'


range      = (1..12)

range.each do |id|

    slug = "%02d" % id

    img = Image.read( "./sandbox/i/basic#{slug}.png" )

    if img.width == 50 && img.height == 50
      ## do nothing; everything ok
    else
      puts "!! ERROR - unknown image dimension #{img.width}x#{img.height}; sorry"
      exit 1
    end

    pix = img.transparent  # ( fuzzy: true )
    pix.save( "./sandbox/ii/basicape#{slug}.png")
end


puts "bye"


