# encoding: utf-8


class TabReader

##
## add more configs - why? why not?
##   add comments and blanks (skip blank lines) - why? why not?
##   e.g. comments = '#'
##        blanks (skip blank lines)
##        rtrim,ltrim,trim

##
##  todo: add  converters: e.g. strip (akk trim / ltrim / rtrim )


def self.read( path, headers: false )
  txt = File.open( path, 'r:utf-8' ).read
	## puts "#{path}:"
  ## pp txt
  parse( txt, headers: headers )
end

def self.parse( txt, headers: false )   ## use parse_rows or parse_lines for array or array results
   rows = []

   if headers.is_a?( Array )
     columns = headers
   else
     columns = nil    ## header row a.k.a. columns / fields
   end

   txt.each_line do |line|
     values = parse_line( line )
     if headers  ## add values as name/value pairs e.g. array of hashes
       if columns.nil?
         columns = values    ## first row is header row
       else
         ## note: will cut-off values if values.size > columns.size
         ##   add warning/error - why? why not?
         ##  if values.size <= columns.size will get filled-up with nil
         pairs = columns.zip(values)
         ## pp pairs
         h = pairs.to_h
         ## pp h

         rows << h
       end
     else       ## add values as is e.g. array of array
       rows << values
     end
   end
   rows
end

def self.foreach( path, headers: false )
  if headers.is_a?( Array )
    columns = headers
  else
    columns = nil    ## header row a.k.a. columns / fields
  end

	File.open( path, 'r:utf-8' ).each_line do |line|
		pp line
		values = parse_line( line )
		if headers  ## add values as name/value pairs e.g. array of hashes
			if columns.nil?
				columns = values    ## first row is header row
			else
				pairs = columns.zip(values)
				h = pairs.to_h
				yield( h )
			end
		else       ## add values as is e.g. array of array
			yield( values )
		end
	end

	# return nil
	nil
end


def self.parse_line( line )
  ## check - can handle comments and blank lines too - why? why not?
  ## remove trailing newlines

  ##  note: chomp('') if is an empty string,
  ##    it will remove all trailing newlines from the string.
	##    use line.sub(/[\n\r]*$/, '') or similar instead - why? why not?
  line = line.chomp('')

  values = line.split("\t")
  values
end

def self.header( path )
  line =  File.open( path, 'r:utf-8' ) do |f|
     if f.eof?
			 ## handle empty file; return empty string; no readline call possible
			 ##  todo/check: return nil from header is no header or [] - why? why not?
			 ##   or throw exception  end of file reached (EOFError) - why? why not?
			  ""
		 else
			 f.readline
		 end
  end

  ## note: line includes \n or \r\n at the end
  ## pp line
  parse_line( line )
end

end # class TabReader




class TabHashReader

def self.read( path, headers: true )
  TabReader.read( path, headers: headers )
end

def self.parse( txt, headers: true )
  TabReader.parse( txt, headers: headers )
end

def self.foreach( path, headers: true, &block )
  TabReader.foreach( path, headers: headers, &block )
end

def self.header( path )   ## add header too? why? why not?
  TabReader.header( path )
end

end # class TabHashReader
