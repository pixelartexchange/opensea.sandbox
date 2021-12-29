

require_relative '../helper'


files = Dir.glob( '../punks.readymade/**/*.png' )


files = files.sort

puts "  #{files.size} file(s)"
pp files[0..10]

#=> 495 file(s)


  ## note: try pixelated image rendering property
  ##   - https://css-tricks.com/keep-pixelated-images-pixelated-as-they-scale/
  ##   - https://developer.mozilla.org/en-US/docs/Web/CSS/image-rendering

buf = ''
buf += <<HTML
<style>
  img.pix  {  image-rendering: pixelated;  }
</style>



<p style='font-size: 80%'>
 <a href='https://github.com/cryptopunksnotdead/punks.readymade'>
    « /punks.readymade
  </a>
</p>


<p>
Yes, you can!  Right-click and save (to download)
the pixel punks
one-by-one in the original 24×24 format.
</p>

<div style='background-color: #638596'>

HTML



files.each do |file|
  next if file.index( '/readymades.png' )  ## skip composites

  # make path relative to root quick hack
  path = file.sub( '../punks.readymade/', '' )
  basename = File.basename( file, File.extname( file ) )
  dirname  = File.basename( File.dirname( file )).gsub( '_I_', ' / ' )

  ## use 4x zoom 24x4 = 96  - why? why not?
  buf << "<a href='https://github.com/cryptopunksnotdead/punks.readymade/blob/master/#{path}'>"
  buf << "<img src='#{path}' class='pix' width='96' height='96'"
  buf << " alt='#{basename}' title='#{basename} in (#{dirname})'"
  buf << ">"
  buf << "</a>"
  buf << "\n"
end
buf << "\n\n"
buf << "</div>"


File.open( './misc/tmp/summary.md', 'w:utf-8' ) { |f| f.write( buf ) }


puts "bye"
