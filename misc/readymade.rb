

require_relative '../helper'

require 'csvreader'



def read_recs( path, collection: )
  recs = []
  rows = CsvHash.read( path )

  category = 'Unknown'
  rows.each do |row|
    values = row.values
    if values[0].strip.start_with?( '=' )
      category = values[0].gsub( '=', '' ).strip   ## remove leading ===
    else
        ## auto-check if override exits  (in dir /iii instead of /ii)
        img_path = row['path'].strip
        img_fullpath = if File.exist?( "./#{collection}/iii/#{img_path}" )
                      "./#{collection}/iii/#{img_path}"
                   else
                      "./#{collection}/ii/#{img_path}"
                   end
      recs << [ img_fullpath,
               row['name'] || img_path.sub( /^[0-9]+-/, '' ).sub( /\.png$/, '' ).strip,
               category
              ]
   end
  end
  recs
end


recs = []
recs += read_recs( './misc/readymade_genius.csv',  collection: 'thecryptogenius' )

puts "  #{recs.size} record(s) in thecryptogenius collections"
#=> 90 record(s) in thecryptogenius


recs += read_recs( './misc/readymade_history.csv', collection: 'histopunks' )

recs += read_recs( './misc/readymade_stars.csv', collection: 'star-punks1' )

recs += read_recs( './misc/readymade_clout.csv', collection: 'clout-punks' )

recs += read_recs( './misc/readymade_genius-ii.csv',  collection: 'genius-punks' )

recs += read_recs( './misc/readymade_unofficial.csv', collection: 'unofficialpunks' )

recs += read_recs( './misc/readymade_cinema.csv', collection: 'cinepunkss' )

recs += read_recs( './misc/readymade_scifi.csv', collection: 'scifipunks' )

recs += read_recs( './misc/readymade_athletes.csv', collection: 'athletes-101' )

# recs += read_recs( './misc/readymade_portraits.csv', collection: 'the-pixel-portraits-og' )

recs += read_recs( './misc/readymade_portraits_ii.csv', collection: 'the-pixel-portraits-og' )

recs += read_recs( './misc/readymade_wunks.csv', collection: 'wunks' )

recs += read_recs( './misc/readymade_punkoftheday.csv', collection: 'punkoftheday' )


puts "  #{recs.size} records:"
pp recs


rootdir = './misc/tmp'
# rootdir = '../punks.readymade'


###
##  todos
##    double check if Salvador Dali in arts has some left-over background pixels???
##
##  fix: pipe smoke in Winston Churchill!!! - change to alpha channel color? others too???
##




names = Hash.new( 0 )  ## track unique name counts


recs.each do |rec|

  path, name, category = rec

  name = slugify( name )

  count = names[ name ] += 1

  name = "#{name}_(#{count})"  if count > 1


  ## todo/check: find a better convetion for category divider (/ => I ???) - why? why not?
  category =  category.gsub( ' ', '_' ).gsub( '/', 'I')


  puts "#{path} =>  #{name}   (#{category})"

  ## skip for now - do not regenerate on every run for now
  next if path.index( 'thecryptogenius/' )
  next if path.index( 'histopunks/' )
  next if path.index( 'star-punks1/' )
  next if path.index( 'clout-punks/' )
  next if path.index( 'genius-punks/' )
  next if path.index( 'unofficialpunks/' )
  next if path.index( 'cinepunkss/' )
  next if path.index( 'scifipunks/' )
  next if path.index( 'athletes-101/' )
  next if path.index( 'the-pixel-portraits-og' )
  next if path.index( 'wunks' )


  img = Image.read( path )
  img = if path.index( 'star-punks1/' )
            ## note: crop from 32x32 to 24x24
            y_offset = if path.index('mohamed_salah')
                           7
                       else
                           8
                       end
            ['albert_einstein',
            'adele',
            'annie_lennox',
            'al_capone',
            'andreas_antonopoulos',
            'arthur_schopenhauer',
            'freddie_mercury',
            'friedrich_nietzsche',
            'julius_caesar',
            'kim_jong-un',
            'mao_zedong',
            'marilyn_manson',
            'martin_heidegger',
            'muhammad_ali',
            'nikola_tesla',
            'pablo_escobar',
            'queen_elizabeth_ii',
            'salvador_dal',
            'sigmund_freud',
            'vincent_van_gogh',
            'terminator',
            'vitalik_buterin',
            ].each do |name|
                if path.index( name )
                   y_offset = 6
                   break
                end
              end
            x_offset = if path.index( 'lewis_hamilton' )
                          2
                       else
                          4
                       end
            img.crop( x_offset, y_offset, 24, 24 ).transparent
        elsif path.index( '034-bob_marley_punk' )
          img.transparent( :linear, fuzzy: true )    ## linear greadient / pattern
        elsif path.index( 'clout-punks/' ) ||
              path.index( 'wunks/' ) ||
              path.index( 'punkoftheday/') ||
              # path.index( 'the-pixel-portraits-og/' ) ||
              # path.index( 'unofficialpunks/' ) ||
              # path.index( 'scifipunks/' ) ||
              # path.index( 'athletes-101/' ) ||
              path.index( 'genius-punks/' )
          img.transparent
        else
            img.transparent( fuzzy: true )
        end

  img.save( "#{rootdir}/#{category}/#{name}.png" )
  img.zoom(4).save( "./misc/tmp/#{category}-I-#{name}@4x.png" )
end


puts "bye"