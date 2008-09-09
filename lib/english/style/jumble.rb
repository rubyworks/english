module English

  module Style
    # Jumble string.
    def jumble
      j = ''
      to_s.split(//).each_with_index{ |c,i| j << ( i % 2 == 0 ? c.downcase : c.upcase ) }
      j
    end
  end

  module StyleReplace
    # In place version of #jumble.
    def jumble!
      replace(jumble)
    end
  end

end

class String #:nodoc:
  include English::Style
  include English::StyleReplace
end

