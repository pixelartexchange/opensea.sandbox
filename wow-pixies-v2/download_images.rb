require_relative '../artbase'


# range = (0..2)    # 5555 items
# range = (3..5554)
range = (5551..5554)
range.each do |id|

  txt = File.open( "./meta/#{id}.json", 'r:utf-8') { |f| f.read }
  data = JSON.parse( txt )

  meta_token_id           = data['assets'][0]['token_id'].strip.to_i( 10 )
  meta_name               = data['assets'][0]['name']
  meta_image_original_url = data['assets'][0]['image_original_url']

  puts "==> reading #{id} - #{meta_token_id} / #{meta_name}..."
  puts "   image_original_url: #{meta_image_original_url}"

  num = if m=meta_name.match( /^Pixie #(?<num>[0-9]+)$/ )
            m[:num].to_i( 10 )
        else
            puts "!! ERROR - cannot find id in >#{meta_name}<"
            exit 1
        end

  if num != meta_token_id
    puts "!! ERROR - token ids do NOT match #{num} != #{meta_token_id}"
  end

  ##
  ##  note: use meta_token_id as authentic id!!! (num has two duplicates / errors!!)
  copy_image( meta_image_original_url, "./token-i/#{meta_token_id}" )

  delay_in_s = 0.3
  puts "sleeping #{delay_in_s}s..."
  sleep( delay_in_s )

end



puts "bye"