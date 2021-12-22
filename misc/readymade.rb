

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
      recs << ["./#{collection}/ii/#{row['path'].strip}",
               row['name'] || row['path'].sub( /^[0-9]+-/, '' ).sub( /\.png$/, '' ).strip,
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

  img = Image.read( path )
  img = if path.index( 'thecryptogenius/' )
            img.transparent( fuzzy: true )
        else
            img.transparent( fuzzy: true )
        end

  img.save( "#{rootdir}/#{category}/#{name}.png" )
  img.zoom(4).save( "./misc/tmp/#{category}-I-#{name}@4x.png" )
end


puts "bye"