require_relative '../artbase'


ids       = Hash.new(0)
token_ids = Hash.new(0)


# range = (0..2)    # 5555 items
# range = (3..5554)
range = (0..5554)
range.each do |id|

  txt = File.open( "./meta/#{id}.json", 'r:utf-8') { |f| f.read }
  data = JSON.parse( txt )

  meta_token_id           = data['assets'][0]['token_id'].strip.to_i( 10 )
  meta_name               = data['assets'][0]['name']
  meta_image_original_url = data['assets'][0]['image_original_url']


  print "#{id}..."   if id % 100 == 0

  num = if m=meta_name.match( /^Pixie #(?<num>[0-9]+)$/ )
            m[:num].to_i( 10 )
        else
            puts "!! ERROR - cannot find id in >#{meta_name}<"
            exit 1
        end

  if num != meta_token_id
    puts "!! ERROR - token ids do NOT match Pixie ##{num} != token_id #{meta_token_id}"
  end

  count = ids[ num ] += 1
  if count > 1
    puts "!!  duplicate num  #{num} (#{count})"
  end

  count = token_ids[ meta_token_id ] += 1
  if count > 1
    puts "!!  duplicate token_id  #{meta_token_id} (#{count})"
  end



  ## check and report if image is missing?
  if File.exist?( "./token-i/#{num}.jpg" ) ||
     File.exist?( "./token-i/#{num}.png" )
    ## everything ok
  else
    puts "!! IMAGE MISSING !!"
    puts "==> reading #{id} - #{meta_token_id} / #{meta_name}..."
    puts "   image_original_url: #{meta_image_original_url}"
  end

  # !! ERROR - token ids do NOT match Pixie #186 != token_id 1921
  #    !!  duplicate num  186 (2)
  # !! ERROR - token ids do NOT match Pixie #76 != token_id 4550
  #    duplicate num  76 (2)
=begin
  if [76, 186].include?( num )
    copy_image( meta_image_original_url, "./token-i/#{meta_token_id}" )

    delay_in_s = 0.3
    puts "sleeping #{delay_in_s}s..."
    sleep( delay_in_s )
  end
=end
end


puts
puts "  #{ids.size} id(s)"
puts "  #{token_ids.size} token id(s)"


puts "bye"