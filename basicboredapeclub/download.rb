#####
# to run use:
#   $ ruby basicboredapeclub/download.rb


require_relative '../helper'


### use/try direct link via baseURI from contract
# https://basicboredapeclub.com/nft/855.png

c = ImageCollection.new( 'basicboredapeclub', 10000,
                          image_base: 'https://basicboredapeclub.com/nft/{id}.png' )

# range = (8432..9999)
# c.download_images( range )

c.download_images




__END__

# https://opensea.io/collection/basicboredapeclub  - 10000 items


c = Collection.new( 'basicboredapeclub', 10000 )
# c.download_meta       ## mode: 'fix'
# c.download_images


puts "bye"


__END__


try to fix:

==> 8432 - basicboredapeclub...
[debug] GET /nft/8432.png uri=https://basicboredapeclub.com/nft/8432.png
Traceback (most recent call last):
        10: from basicboredapeclub/download.rb:14:in `<main>'
         9: from opensea.sandbox/helper.rb:168:in `download_images'
         8: from opensea.sandbox/helper.rb:168:in `each'
         7: from opensea.sandbox/helper.rb:175:in `block in download_images'
         6: from opensea.sandbox/helper.rb:106:in `copy_image'
         5: from ruby/2.7.0/net/http.rb:1483:in `request'
         4: from ruby/2.7.0/net/http.rb:932:in `start'
         3: from ruby/2.7.0/net/http.rb:943:in `do_start'
         2: from ruby/2.7.0/net/http.rb:1009:in `connect'
         1: from ruby/2.7.0/net/protocol.rb:44:in `ssl_socket_connect'
ruby/2.7.0/net/protocol.rb:44:in `connect_nonblock': An existing connection was forcibly closed by the remote host. - SSL_connect (Errno::ECONNRESET)





try to fix:

1017 -  image_url is missing / nil



==> 1016.json  -  #1016
    >https://lh3.googleusercontent.com/7tKmvSeu6QqMxgirW8T4OoSiBLviFgIcFwvazIMfjjY3kokf4WpUZRNfB8uwGGitRITGNv9nWzhkr7El5h0-DI96nTGde2_7aMMJ<
[debug] GET /7tKmvSeu6QqMxgirW8T4OoSiBLviFgIcFwvazIMfjjY3kokf4WpUZRNfB8uwGGitRITGNv9nWzhkr7El5h0-DI96nTGde2_7aMMJ uri=https://lh3.googleusercontent.com/7tKmvSeu6QqMxgirW8T4OoSiBLviFgIcFwvazIMfjjY3kokf4WpUZRNfB8uwGGitRITGNv9nWzhkr7El5h0-DI96nTGde2_7aMMJ
200 OK
  content_type: image/png, content_length: 10469
sleeping 0.3s...
up 13.472341763333333 mins 28.34050579999996 secs (total 808.3405058 secs)
Traceback (most recent call last):
        6: from basicboredapeclub/download.rb:13:in `<main>'
        5: from opensea.sandbox/helper.rb:362:in `download_images'
        4: from opensea.sandbox/helper.rb:385:in `download_images'
        3: from opensea.sandbox/helper.rb:385:in `each'
        2: from opensea.sandbox/helper.rb:388:in `block in download_images'
        1: from opensea.sandbox/helper.rb:290:in `name'
opensea.sandbox/helper.rb:337:in `_normalize': undefined method `gsub' for nil:NilClass (NoMethodError)


try direct download via baseURI e.g.

https://basicboredapeclub.com/855

results in:

{"dna":"c751455af3b18233d2d6fd0cf0849d1e2fa5f5b4",
 "name":"#855",
 "description":"Basic Bored Ape Club",
 "image":"https://basicboredapeclub.com/nft/855.png",
 "edition":855,
 "date":1640519144549,
 "attributes":
  [{"trait_type":"Background","value":"Army Green"},
   {"trait_type":"Fur","value":"Pink"},
   {"trait_type":"Neck","value":"Anchor Tattoo"},
   {"trait_type":"Mouth","value":"Unshaven"},
   {"trait_type":"Eye","value":"Zombie Eye"},
   {"trait_type":"Earring","value":"Gold"},
  {"trait_type":"Head","value":"Peaky Blinders"}],
 "compiler":"Basic Bored Ape Club"}