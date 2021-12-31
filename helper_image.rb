######################
#  pixelart image extensions
#    move upstream!!!!!


module Pixelart

class Image
  def crop( x, y, crop_width, crop_height )
    self.class.new(  nil, nil,
                     self.image.crop( x,y, crop_width, crop_height ) )
  end


  def sample( offsets )
    ## note: for now always assume square image (e.g. 24x24, 32x32 and such)
    width = height = offsets.size

    puts "     #{self.width}x#{self.height} => #{width}x#{height}"


    dest = Image.new( width, height )

    offsets.each do |offset_x, x|
      offsets.each do |offset_y, y|
         pixel = self[offset_x,offset_y]

         dest[x,y] =  pixel
      end
    end

    dest
  end
  alias_method :pixelate, :sample


  def transparent( style = :solid, fuzzy: false )
    img = Image.new( width, height )


    background = self[0,0]

    bh,bs,bl =  Color.to_hsl( background )
    bh = (bh % 360)  ## might might negative degree (always make positive)

    height.times do |y|
        if style == :linear
          background = self[0,y]

          bh,bs,bl =  Color.to_hsl( background )
          bh = (bh % 360)  ## might might negative degree (always make positive)
        end
      width.times do |x|
        pixel = self[x,y]

        if background == 0  ## special case if background is already transparent keep going
          img[x,y] =  pixel
        elsif fuzzy
          ## check for more transparents
            ##   not s  is 0.0 to 0.99  (100%)
            ##   and l  is 0.0 to 0.99  (100%)
          h,s,l =  Color.to_hsl( pixel )
          h = (h % 360)  ## might might negative degree (always make positive)

          ## try some kind-of fuzzy "heuristic" match on background color
          if ((h >= bh-5) && (h <= bh+5)) &&
             ((s >= bs-0.07) && (s <= bs+0.07)) &&
             ((l >= bl-0.07) && (l <= bl+0.07))
           img[x,y] = 0  ## Color::TRANSPARENT

           if h != bh || s != bs || l != bl
              # report fuzzy background color
              puts "  #{x}/#{y} fuzzy background #{[h,s,l]} ~= #{[bh,bs,bl]}"
           end
          else
            img[x,y] =  pixel
          end
        else
           if pixel == background
            img[x,y] = 0   ## Color::TRANSPARENT
           else
             img[x,y] =  pixel
           end
        end
      end
    end
    img
  end # method transparent
end  # class Image



class ImageComposite


def add_glob( glob )
  files = Dir.glob( glob )
  puts "#{files.size} file(s) found matching >#{glob}<"


  files = files.sort
  ## puts files.inspect

  files.each_with_index do |file,i|
     puts "==> [#{i+1}/#{files.size}] - #{file}"
     img = Image.read( file )

     self << img    ## todo/check: use add alias - why? why not?
  end
end

end   # class ImageComposite
end   # module Pixelart



