
COLLECTION = Collection.new( 'cryptoapes-official', 6969,
                               format: '35x35',
                               source: '512x512',

####
# e.g CryptoApe #1  => 1
#     CryptoApe #42 => 42
meta_slugify:  /^CryptoApe #(?<num>[0-9]+)$/,
)


