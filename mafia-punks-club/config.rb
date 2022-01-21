
COLLECTION = Collection.new( 'mafia-punks-club', 195,

##
#  e.g.  Mafia Punks Club #1
meta_slugify: /^Mafia Punks Club #(?<num>[0-9]+)/,

patch: {
  trait_types: {
    'Accessory' => 'Accessories' ,
    },

  ##
  ## todo/check: auto-downcase trait values in stats - why? why not?
  trait_values: {
    'Black hair'            => 'Black Hair',
    'Bow tie'               => 'Bow Tie',
    'Extended goatee beard' => 'Extended Goatee Beard',
    'Thin mustache'         => 'Thin Mustache',
    'White shirt'           => 'White Shirt',
    'Black gangster hat'    => 'Black Gangster Hat',
    'Foxy smile'            => 'Foxy Smile',
    'Gangster shades'       => 'Gangster Shades',
    'Black shirt'           => 'Black Shirt'
   },
},

)

