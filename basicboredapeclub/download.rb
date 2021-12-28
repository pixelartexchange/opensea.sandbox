#####
# to run use:
#   $ ruby basicboredapeclub/download.rb


require_relative '../helper'


# https://opensea.io/collection/basicboredapeclub  - 10000 items

c = Collection.new( 'basicboredapeclub', 10000 )
# c.download_meta
c.download_images


puts "bye"


__END__

try to fix:

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

