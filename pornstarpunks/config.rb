
# https://opensea.io/collection/pornstarpunks

COLLECTION = Collection.new( 'pornstarpunks', 150,
format: '32x32',
source: '512x512',


#################
# e.g.  Lana Rhoades #001
#       Shanel Uzi   #129

meta_slugify:  /^(?<name>.+) #(?<num>[0-9]+)$/,
)

