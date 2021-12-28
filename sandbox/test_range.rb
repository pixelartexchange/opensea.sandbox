

class C

  def initialize( items )
    @items = items
  end

  def each( &block )
    range = (0...@items)   ## note: use three-dots (...) exclusive (0 to 99) for 100, for example.
    puts " #{range.to_a.size} item(s)"
    range.each do |id|
       block.call( id )
    end
  end
end  # class C



c = C.new( 100 )

c.each do |id|
  print "#{id} "
end
print "\n"


c = C.new( 1 )

c.each do |id|
  print "#{id} "
end
print "\n"


puts "bye"