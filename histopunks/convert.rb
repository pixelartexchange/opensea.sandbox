##################
#  special case
#    convert via magick from jpg format to .png
#
# to run use:
#    $ ruby histopunks/convert.rb


collection = 'histopunks'
range      = (0..147)   # 148 items


range.each do |id|

  cmd = "magick convert #{collection}/i/#{id}.jpg #{collection}/i/#{id}.png "
  puts "==> #{id} - #{cmd}"
  system( cmd )
end

puts "bye"