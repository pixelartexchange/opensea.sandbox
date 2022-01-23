

## todo/check: find a better name for source -
##     inputs? sources? accept?  or such - why? why not?



###
## known meta data errata / bugs:
##   - Blocky Doge #3   lists as as Expression => Cream Fur
##                                   Cream Fur is a Fur Trait NOT an Expression
##                             e.g.  Fur => Cream Fur


COLLECTION = Collection.new( 'blockydoge', 100,
                              format: '60x60',   source: '512x512',

#####
#  Blocky Doge #1  => 1
meta_slugify: /^Blocky Doge #(?<num>[0-9]+)$/,
)
