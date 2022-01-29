
$LOAD_PATH.unshift( "../../pixelart/pixelart/lib" )
$LOAD_PATH.unshift( "../../artbase/lib" )

require_relative '../artbase'


##
#  scan pixel lines to try to auto-detect resolution and pixel offsets / steps

y = 112

# img = Image.read( "./page-i/2.png" )
img = Image.read( "./page-i_(3)/22.png" )

## get runs  - (minimum 3px in seq of same colors)


def dump_runs( img, y, excludes )
  runs = []

  run  = [0,0,0]

  puts "==> y:#{y}:"
  img.width.times do |x|

     last_pixel = x > 0 ? img[x-1,y] : nil

     pixel = img[x,y]

     if pixel != last_pixel
        if run[2] > 2
          runs << run
          print " - x#{run[0]}:#{Color.to_hex(run[1])} (#{run[2]}) - "
        else
          run[2].times do |offset|
             excludes[ run[0]+offset ] += 1
          end
        end

        ## start new run candidate
        run = [x,pixel, 1]
     end
     run[2] += 1
  end
  if run[2] > 2
    runs << run
    print " - x#{run[0]}:#{Color.to_hex(run[1])} (#{run[2]}) - "
  else
    run[2].times do |offset|
       excludes[ run[0]+offset ] += 1
    end
  end
print "\n"

  runs
end


excludes_x = Hash.new( 0 )

# dump_runs( img,  82, excludes_x )
# dump_runs( img,  83, excludes_x )
# dump_runs( img,  84, excludes_x )


puts
# dump_runs( img, 112, excludes_x )
# dump_runs( img, 113, excludes_x )
# dump_runs( img, 114, excludes_x )

puts
# dump_runs( img, 199, excludes_x )
# dump_runs( img, 210, excludes_x )

center = img.height / 2
dump_runs( img, center, excludes_x )



dump_runs( img, 370, excludes_x )

dump_runs( img, 550, excludes_x )


dump_runs( img, 910, excludes_x )


steps_x        = Hash.new(0)
steps_x_width  = Hash.new(0)

100.times do |i|
  y = 5 + i*10
  runs = dump_runs( img, y, excludes_x )
  ## pp runs

  runs.each do |run|
    steps_x[ run[0] ] += 1
    steps_x_width[ run[2] ] += 1
  end
end



steps_x_exp = Image.calc_sample_steps( 1000, 24, center: false )
puts steps_x_exp.inspect

puts "steps_x (#{steps_x.size} of 24):"
pp steps_x.sort { |l,r| l[0] <=> r[0] }

puts "steps_x_width:"
pp steps_x_width.sort { |l,r| l[0] <=> r[0] }


def fill_steps( sparse_steps, exp )
  puts "sparse_steps - #{sparse_steps.size} of #{exp.size}:"
  puts sparse_steps.inspect

  steps = []

  next_step = sparse_steps.shift

  exp.each_with_index do |step_exp, i|
      if next_step && next_step < (step_exp + 20)
         steps << next_step

         next_step = sparse_steps.shift
         puts "  next step #{i}: #{next_step} - left #{sparse_steps.size}"
      else
         steps << step_exp
         puts " filling step #{i} with #{step_exp}"
      end
  end

  steps
end

steps_x_sorted = steps_x.sort { |l,r| l[0] <=> r[0] }
steps_x_values = steps_x_sorted.map { |rec| rec[0] }

steps_x_complete = fill_steps( steps_x_values, steps_x_exp )
puts "steps_x_complete (#{steps_x_complete.size}):"
puts steps_x_complete.inspect


puts "excludes_x:"
pp excludes_x

puts "bye"