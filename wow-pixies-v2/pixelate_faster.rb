

range = (308..5554)   # 5555 items
range.each do |id|

  puts "==> #{id}  - reading / decoding #{id} ..."
  start = Time.now

  slug = "%04d" % id

  cmd = "./pixelator -top_x=8 token-i/#{id}.png 1498 1500 ii/#{slug}.png 98 98"
  puts cmd
  res = system( cmd )

  if res != true
    puts "!! ERROR - sorry system execution failed"
    exit 1
  end

  stop = Time.now
  diff = stop - start

  puts "  in #{diff} sec(s)\n"
end

puts "bye"

