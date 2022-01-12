

class Tool

  def self.collection=(value)
    @collection = value
  end


  def self.main( args=ARGV )
    puts "==> welcome to collection tool with args:"
    pp args

    options = { }
    parser = OptionParser.new do |opts|

      opts.on("--offset NUM", Integer,
              "Start counting at offset (default: 0)") do |num|
          options[ :offset]  = num
      end

      opts.on("--limit NUM", Integer,
              "Limit collection (default: ∞") do |num|
          options[ :limit]  = num
      end

      ## todo/fix: unsupported argument type: Range
      ## opts.on("--range RANGE", Range,
      ##        "Range of collection (default: 0..∞") do |range|
      ##    options[ :range]  = range
      ## end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    parser.parse!( args )
    puts "options:"
    pp options

    puts "args:"
    pp args

    if args.size == 0
      puts "!! ERROR - no command found - use dl/download ..."
      puts ""
      exit
    end

    command    = args[0]
    subcommand = args[1]


    if ['d','dl','down', 'download'].include?( command )
      if subcommand
         if ['m', 'meta'].include?( subcommand )
           download_meta
         elsif ['i', 'img', 'image', 'images'].include?( subcommand )
           download_images
         end
      else
        download_meta
        download_images
      end
    elsif ['p', 'px', 'pix', 'pixel', 'pixelate'].include?( command )
      pixelate
    elsif ['m', 'meta'].include?( command )
      download_meta
    elsif ['i', 'img', 'image', 'images'].include?( command )
      download_images
    else
      puts "!! ERROR - unknown command >#{command}<, sorry"
    end

    puts "bye"
  end


  def self.download_meta
      puts "==> download meta"
      @collection.download_meta;
  end

  def self.download_images
     puts "==> download images"
     @collection.download_images
  end

  def self.pixelate
    puts "==> pixelate"
    @collection.pixelate
  end
end # class Tool