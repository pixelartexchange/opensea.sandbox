#############################################
#  generate / create pixel punk quiz composites - who is ___?

require 'pixelart'




pop_rock = [
  Image.read( './thecryptogenius/ii/076-freddie_mercury.png' ),
  Image.read( './thecryptogenius/ii/079-david_bowie.png' ),
  Image.read( './thecryptogenius/ii/082-bob_marley.png' ),

  Image.read( './thecryptogenius/ii/083-jimi_hendrix.png' ),
  Image.read( './unofficialpunks/ii/047-lady_gaga_punk.png' ),
  Image.read( './thecryptogenius/ii/067-michael_jackson.png' ),

  Image.read( './thecryptogenius/ii/072-john_lennon.png' ),
  Image.read( './thecryptogenius/ii/088-whitney_houston.png' ),
  Image.read( './unofficialpunks/ii/051-billie_eilish_punk.png' ),
]


pop_rock_2 = [
  Image.read( './histopunks/ii/032-kurt_cobain.png' ),
  Image.read( './unofficialpunks/ii/094-pink_punk.png' ),
  Image.read( './unofficialpunks/ii/084-snoop_dogg_punk.png' ),

  Image.read( './histopunks/ii/056-prince.png' ),
  Image.read( './unofficialpunks/ii/025-freebritney_britney_spears_punk.png' ),
  Image.read( './unofficialpunks/ii/086-justin_bieber_punk.png' ),

  Image.read( './histopunks/ii/113-eddie_van_halen.png' ),
  Image.read( './unofficialpunks/ii/085-stevie_wonder_punk.png' ),
  Image.read( './histopunks/ii/052-amy_winehouse.png' ),
]



## quiz no. 1
composite = ImageComposite.new( 3, 3 )

pop_rock.each do |punk|
  composite << punk
end

composite.save( "./i/quiz_i.png" )
composite.zoom(2).save( "./i/quiz_i@2x.png" )
composite.zoom(4).save( "./i/quiz_i@4x.png" )


## quiz no. 2
composite = ImageComposite.new( 3, 3 )

pop_rock_2.each do |punk|
  composite << punk
end

composite.save( "./i/quiz_ii.png" )
composite.zoom(2).save( "./i/quiz_ii@2x.png" )
composite.zoom(4).save( "./i/quiz_ii@4x.png" )



autocrats = [
  Image.read( './star-punks1/ii/donald_trump.png' ),
  Image.read( './star-punks1/ii/vladimir_putin.png' ),
  Image.read( './star-punks1/ii/alexander_lukashenko.png' ),

  Image.read( './star-punks1/ii/recep_tayyip_erdoan.png' ),
  Image.read( './star-punks1/ii/xi_jinping.png' ),
  Image.read( './star-punks1/ii/kim_jong-un.png' ),

  Image.read( './star-punks1/ii/adolf_hitler.png' ),
  Image.read( './star-punks1/ii/joseph_stalin.png' ),
  Image.read( './star-punks1/ii/mao_zedong.png' ),

  # Image.read( './star-punks1/ii/fidel_castro.png' ),
  # Image.read( './star-punks1/ii/darth_vader.png' ),
]


## quiz no. 3
composite = ImageComposite.new( 3, 3, width: 32, height: 32 )

autocrats.each do |punk|
  composite << punk
end

composite.save( "./i/quiz_iii.png" )
composite.zoom(2).save( "./i/quiz_iii@2x.png" )
composite.zoom(4).save( "./i/quiz_iii@4x.png" )



paintings = [
  Image.read( './clout-punks/ii/girl_with_a_pearl_earring.png' ),
  Image.read( './clout-punks/ii/american_gothic.png' ),
  Image.read( './clout-punks/ii/michelangelo_portrait.png' ),

  Image.read( './clout-punks/ii/van_gogh_self-portrait.png' ),
  Image.read( './clout-punks/ii/mona_lisa.png' ),
  Image.read( './clout-punks/ii/pablo_picasso.png' ),

  Image.read( './clout-punks/ii/a_sunday_afternoon_on_the_island_of_la_grande_jatte.png' ),
  Image.read( './clout-punks/ii/the_son_of_man.png' ),
  Image.read( './clout-punks/ii/the_scream.png' ),

#  Image.read( './clout-punks/ii/claude_monet_self_portrait.png' ),
]


## quiz no. 4
composite = ImageComposite.new( 3, 3 )

paintings.each do |punk|
  composite << punk
end

composite.save( "./i/quiz_iiii.png" )
composite.zoom(2).save( "./i/quiz_iiii@2x.png" )
composite.zoom(4).save( "./i/quiz_iiii@4x.png" )
composite.zoom(8).save( "./i/quiz_iiii@8x.png" )




enterprise = [
  Image.read( '../punks.readymade/cinema_I_fictional_characters/sulu.png' ),
  Image.read( '../punks.readymade/cinema_I_fictional_characters/nyota_uhura.png' ),
  Image.read( '../punks.readymade/cinema_I_fictional_characters/spock.png' ),
  Image.read( '../punks.readymade/cinema_I_fictional_characters/kirk.png' ),
]

## quiz no. 5
composite = ImageComposite.new( 2, 2 )

enterprise.each do |punk|
  composite << punk
end



composite.save( "./i/quiz_v.png" )
composite.zoom(2).save( "./i/quiz_v@2x.png" )
composite.zoom(4).save( "./i/quiz_v@4x.png" )
composite.zoom(8).save( "./i/quiz_v@8x.png" )





star_wars = [
  'c3po_(3)',
  'chewbacca',
  'count_dooku',
  'darth_maul',

  'han_solo',
  'grogu',
  'darth_sidious',
  'lando_calrissian',

  'han_solo_hoth',
  'darth_vader_(2)',
  'luke_skywalker',
  'qui-gon_jinn',

  'mace_windu',
  'obi-wan_kenobi',
  'princess_leia_(2)',
  'r2d2',
]

## quiz no. 6
composite = ImageComposite.new( 4, 4 )

star_wars.each do |name|
  punk = Image.read( "../punks.readymade/cinema_I_star_wars/#{name}.png" )
  composite << punk
end



composite.save( "./i/quiz_vi.png" )
composite.zoom(2).save( "./i/quiz_vi@2x.png" )
composite.zoom(4).save( "./i/quiz_vi@4x.png" )
composite.zoom(8).save( "./i/quiz_vi@8x.png" )







def gen_palette( hex )
  ## from black to white (with upper/darker and lower/lighter cut-offs)
  color = Color.parse( hex )
  h,s,l = Color.to_hsl( color )

  pp h
  pp s
  pp l

  darker = 0.3    ## cut-off colors starting from black
  lighter = 0.05   ## cut-off colors starting from white

  ldiff = (1.0 - darker - lighter)

  puts "  ldiff: #{ldiff}"

  colors = []
  256.times do |i|
     lnew = darker+(ldiff*i / 256.0)
     puts "  #{i} - #{lnew}"
     colors << Color.from_hsl( h, s, lnew)
  end

  colors
end




beatles = [
  'john_lennon',
  'paul_mccartney_(2)',
  'ringo_starr_(2)',
  'george_harrison_(2)',
]

## quiz no. 7


composite = ImageComposite.new( 2, 2 )

RED    = '#ff0000'
GREEN  = '#00ff00'
YELLOW = '#ffff00'
BLUE   = '#0000ff'

backgrounds = [YELLOW, RED, BLUE, GREEN]
beatles.each_with_index do |name,i|
  punk = Image.new( 24, 24, backgrounds[ i ] )
  punk.compose!( Image.read( "../punks.readymade/music_I_pop-n-rock/#{name}.png" ))
  composite << punk
end



composite.save( "./i/quiz_vii.png" )
composite.zoom(2).save( "./i/quiz_vii@2x.png" )
composite.zoom(4).save( "./i/quiz_vii@4x.png" )
composite.zoom(8).save( "./i/quiz_vii@8x.png" )



## try with "monochrome colors"
composite = ImageComposite.new( 2, 2 )

beatles.each_with_index do |name,i|
  punk = Image.read( "../punks.readymade/music_I_pop-n-rock/#{name}.png" )
  punk = punk.change_palette8bit( gen_palette( backgrounds[ i ])  )

  img = Image.new( 24, 24, backgrounds[ i ] )
  img.compose!( punk )

  composite << img
end

composite.save( "./i/quiz_vii_(2).png" )
composite.zoom(2).save( "./i/quiz_vii_(2)@2x.png" )
composite.zoom(4).save( "./i/quiz_vii_(2)@4x.png" )
composite.zoom(8).save( "./i/quiz_vii_(2)@8x.png" )




## try variant with all left-two-right and "flipped" looking from top
composite = ImageComposite.new( 4, 1, width: 24, height: 24*2 )

beatles.each_with_index do |name,i|
  punk = Image.read( "../punks.readymade/music_I_pop-n-rock/#{name}.png" )
  punk = punk.flip
  punk = punk.change_palette8bit( gen_palette( backgrounds[ i ])  )

  img  = Image.new( 24, 24*2, backgrounds[ i ] )
  img.compose!( punk, 0, 0 )
  composite << img
end

composite.save( "./i/quiz_vii_(3).png" )
composite.zoom(2).save( "./i/quiz_vii_(3)@2x.png" )
composite.zoom(4).save( "./i/quiz_vii_(3)@4x.png" )
composite.zoom(8).save( "./i/quiz_vii_(3)@8x.png" )



puts "bye"