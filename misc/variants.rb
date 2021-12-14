#############################################
#  compare punk variants from different collections

require 'pixelart'




elvis = [Image.read( './unofficialpunks/ii/076-elvis_punk.png' ),
         Image.read( './thecryptogenius/ii/087-elvis_presley.png' ),
         Image.read( './histopunks/ii/021-elvis_presley.png' )]


marilyn      = [Image.read( './unofficialpunks/ii/072-casual_marilyn_monroe.png'),
                Image.read( './thecryptogenius/ii/081-marilyn_monroe.png' ),
                Image.read( './histopunks/ii/007-marilyn_monroe.png' ) ]

warhol       = [Image.read( './unofficialpunks/ii/017-andy_warhol_punk.png'),
                Image.read( './thecryptogenius/ii/043-andy_warhol.png' ),
                Image.read( './histopunks/ii/036-andy_warhol.png' ) ]

whitney      = [Image.new( 24,24 ),
                Image.read( './thecryptogenius/ii/088-whitney_houston.png' ),
                Image.read( './histopunks/ii/022-whitney_houston.png' ) ]

hendrix      = [Image.new( 24,24 ),
                Image.read( './thecryptogenius/ii/083-jimi_hendrix.png' ),
                Image.read( './histopunks/ii/072-jimi_hendrix.png') ]


## elvis series
composite = ImageComposite.new( 3, 1 )

composite << elvis[0]
composite << elvis[1]
composite << elvis[2]

composite.save( "./i/elvis.png" )
composite.zoom(2).save( "./i/elvis@2x.png" )
composite.zoom(4).save( "./i/elvis@4x.png" )


## more series
composite = ImageComposite.new( 3, 5 )

composite << elvis[0]
composite << elvis[1]
composite << elvis[2]

composite << marilyn[0]
composite << marilyn[1]
composite << marilyn[2]

composite << warhol[0]
composite << warhol[1]
composite << warhol[2]

composite << whitney[0]
composite << whitney[1]
composite << whitney[2]

composite << hendrix[0]
composite << hendrix[1]
composite << hendrix[2]


composite.save( "./i/variants.png" )
composite.zoom(2).save( "./i/variants@2x.png" )
composite.zoom(4).save( "./i/variants@4x.png" )


puts "bye"
