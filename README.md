# tabreader - read in tabular datafiles in text in the tab format

* home  :: [github.com/datatxt/tabreader](https://github.com/datatxt/tabreader)
* bugs  :: [github.com/datatxt/tabreader/issues](https://github.com/datatxt/tabreader/issues)
* gem   :: [rubygems.org/gems/tabreader](https://rubygems.org/gems/tabreader)
* rdoc  :: [rubydoc.info/gems/tabreader](http://rubydoc.info/gems/tabreader)
* forum :: [wwwmake](http://groups.google.com/group/wwwmake)


## Usage

Yes, it's a simple as:

``` ruby
line = "1\t2\t3"
values = line.split( "\t" )
pp values
# => ["1","2","3"]
```

or the "magic" packaged up in `TabReader`:

``` ruby
line = "1\t2\t3"
values = TabReader.parse_line( line )
pp values
# => ["1","2","3"]
```

or use the convenience helpers:

``` ruby
txt <<=TAB
1\t2\t3
4\t5\t6
TAB

records = TabReader.parse( txt )
pp records
# => [["1","2","3"],
#     ["5","6","7"]]

# -or-

records = TabReader.read( "values.tab" )
pp records
# => [["1","2","3"],
#     ["5","6","7"]]

# -or-

TabReader.foreach( "values.tab" ) do |rec|
  pp rec
end
## => ["1","2","3"]
## => ["5","6","7"]
```


### What about headers?

Use the `TabHashReader`
if the first line is a header (or if missing pass in the headers
as an array) and you want your records as hashes instead of arrays of values.
Example:

``` ruby
txt <<=TAB
A\tB\tC
1\t2\t3
4\t5\t6
TAB

records = TabHashReader.parse( txt )
pp records

# -or-

txt2 <<=TAB
1\t2\t3
4\t5\t6
TAB

records = TabHashReader.parse( txt2, headers: ["A","B","C"] )
pp records

# => [{"A": "1", "B": "2", "C": "3"},
#     {"A": "4", "B": "5", "C": "6"}]

# -or-

records = TabHashReader.read( "hash.tab" )
pp records
# => [{"A": "1", "B": "2", "C": "3"},
#     {"A": "4", "B": "5", "C": "6"}]

# -or-

TabHashReader.foreach( "hash.tab" ) do |rec|
  pp rec
end
# => {"A": "1", "B": "2", "C": "3"}
# => {"A": "4", "B": "5", "C": "6"}
```





## Frequently Asked Questions (FAQ) and Answers

### Q: Why NOT use `CSV.read( col_sep: "\t", quote_char: "∅" )`?

Tab != CSV

The tab format is an (even) simpler format than
the comma-separated values (CSV) classic format. How?

The tab format has NO escape rules.
A double quote (`"`) is a double quote (`"`). Example:

```
"1"→"2"→"3"
4→5→6
```
vs

```
"1","2","3"
4,5,6
```

Turns into `"1", "2", "3"` and `4, 5, 6`
in tab and `1, 2, 3` and `4, 5, 6` in CSV.
Note: The surrounding double quotes get stripped in CSV.
You have to double up double quotes (e.g. `""`)
for adding "literal" double quotes in CSV:

```
"""1""","""2""","""3"""
4,5,"Six says, ""Hello, World!"""
```

vs

```
"1"→"2"→"3"
4→5→Six says, "Hello, World!"
```

Thus, to avoid any surprises, do NOT use
`CSV.read( col_sep: "\t", quote_char: "∅" )` and friends for tab.
Note: Simpler also equals faster :-).



### Q: What's the tab format?

Let's reprint the (complete) tab spec(ification) right here
(in an edited simpler version):

A tab file encodes a number of records that may contain multiple fields.
Each record is represented as a single line.
Each field value is represented as text.
Fields in a record are separated from each other by a tab character.

Note that fields that contain tabs are not allowable in this encoding.

Here is a quick grammar in Backus-Naur Form (BNF):

```
field    ::= [character]+             # multiple characters
record   ::= field [TAB field]+ EOL   # at least one field, or more
tab      ::= record+
```

Example:

```
Name→Age→Address
Paul→23→1115 W Franklin
Bessy the Cow→5→Big Farm Way
Zeke→45→W Main St
```

(Source: [Tab Spec @ IANA Media Types](https://www.iana.org/assignments/media-types/text/tab-separated-values))





### Q: Why tab?

The tab format works great with
command line text wrangling / processing tools
because you can split lines / records on tab
(with no exceptions or extra escape rules).
Use classics such as `cut`, `paste`, `sort`, `uniq`, `grep`, `sed`, `awk`  
and many more.




### Q: Why NOT tab?

Let's quote from the Awesome CSV page:

In theory the tab (`\t`) separator is perfect. Values never use tabs, don't they?  So why hasn't the tab separator taken off?

In practice tab separators are invisible or look like spaces and often you cannot tell if a space is a tab or not.

Thus, tab works great only and only (like space) if your values do NOT use spaces and you treat a tab like a space.

(Source: [Awesome CSV @ CSV v1.1](https://github.com/csv11/awesome-csv))



## Best of Both Worlds

Use the `csv2tab` tool to convert comma-separated values (CSV) datafiles
to tab and use the `tab2csv` tool to convert tab datafiles to  
comma-separated values (CSV).




## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `tabreader` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
