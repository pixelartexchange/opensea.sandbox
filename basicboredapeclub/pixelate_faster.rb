require 'json'


collection = 'basicboredapeclub'
## range      =  (38..9999)   #(0..9999)   # 10000 items
## range      =  (1000..1009)


range = (0..9999)


range.each do |id|

  puts "==> #{id}  - reading / decoding #{id} ..."
  start = Time.now

  slug = "%04d" % id

  cmd = "./pixelator i/#{id}.png 2400 ii/#{slug}.png 50"
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


