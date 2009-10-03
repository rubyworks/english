module English

  # English Writing Structure
  #
  # Methods for identifying and ultizing structural language elements.
  #
  module Structure

    # If block given, iterate through each word.
    #
    #   "a string".each_word { |word, range| ... }
    #    
    # Returns an array of words.
    #
    #   "abc 123".words  #=> ["abc","123"]
    #
    def self.words(string, &yld)
      if block_given?
        scan(/([-'\w]+)/).each do |word|
          range = $~.begin(0)...$~.end(0)
          if yld.arity == 1
            yld.call(word)
          else
            yld.call(word, range)
          end
        end
      else
        scan(/([-'\w]+)/)
      end
    end

    #
    def self.sentences(string)
      if block_given?
        scan(/(.*?\.\ )/).each do |sentence|
          range = $~.begin(0)...$~.end(0)
          if yld.arity == 1
            yld.call(sentence)
          else
            yld.call(sentence, range)
          end
        end
      else
        scan(/(.*?\.\ )/)
      end
    end

    #
    def self.paragraph(string)
      if block_given?
        scan(/(.*?\n\s{2,})/).each do |paragraph|
          range = $~.begin(0)...$~.end(0)
          if yld.arity == 1
            yld.call(paragraph)
          else
            yld.call(paragraph, range)
          end
        end
      else
        scan(/(.*?\n\s{2,})/)
      end
    end



    # TODO: This is alternateive from glue: worth providing?
    #
    # Enforces a maximum width of a string inside an
    # html container. If the string exceeds this maximum width
    # the string gets wraped.
    #
    # Not really useful, better use the CSS overflow: hidden
    # functionality.
    #
    # === Input:
    # the string to be wrapped
    # the enforced width
    # the separator used for wrapping
    #
    # === Output:
    # the wrapped string
    #
    # === Example:
    #  text = "1111111111111111111111111111111111111111111"
    #  text = wrap(text, 10, " ")
    #  p text # => "1111111111 1111111111 1111111111"
    #
    # See the test cases to better understand the behaviour!

    #   def wrap(width = 20, separator = " ")
    #     re = /([^#{separator}]{1,#{width}})/
    #     scan(re).join(separator)
    #   end

    # Word wrap a string not exceeding max width.
    #
    #   puts "this is a test".word_wrap(4)
    #
    # _produces_
    #
    #   this
    #   is a
    #   test
    #
    # CREDIT: Gavin Kistner
    # CREDIT: Dayne Broderson

    def self.word_wrap(string, col_width=79)
      string.dup.word_wrap!( col_width )
    end

    # As with #word_wrap, but modifies the string in place.
    #
    # CREDIT: Gavin Kistner
    # CREDIT: Dayne Broderson

    def self.word_wrap!(string, col_width=79)
      string.gsub!( /(\S{#{col_width}})(?=\S)/, '\1 ' )
      string.gsub!( /(.{1,#{col_width}})(?:\s+|$)/, "\\1\n" )
      string
    end

    # old def

    #def word_wrap(max=80)
    #  c = dup
    #  c.word_wrap!(max)
    #  c
    #end

    #def word_wrap!(max=80)
    #  raise ArgumentError, "Wrap margin too low: #{n}" if max <= 2
    #  #gsub!( Regexp.new( "(.{1,#{max-1}}\\w)\\b\\s*" ), "\\1\n")
    #  gsub!( /(.{1,#{max-1}}\S)([ ]|\n)/, "\\1\n")
    #end

  end

  class String #:nodoc:

    #
    def words(&blk)
      if block_given?
        Structure.words(self, &blk)
      else
        Structure.words(self).to_enum(:each)
      end
    end

    #
    def each_word(&blk)
      Structure.words(self, &blk)
    end

    #
    def sentences(&blk)
      if block_given?
        Structure.sentences(self, &blk)
      else
        Structure.sentences(self).to_enum(:each)
      end
    end

    #
    def each_sentences(&blk)
      Structure.sentences(self, &blk)
    end

    #
    def paragraphs(&blk)
      if block_given?
        Structure.paragraphs(self, &blk)
      else
        Structure.paragraphs(self).to_enum(:each)
      end
    end

    #
    def each_paragraphs(&blk)
      Structure.paragraphs(self, &blk)
    end

    #
    def word_wrap(col_width=79)
      Structure.word_wrap(self, col_width=79)
    end

    #
    def word_wrap!(col_width=79)
      Structure.word_wrap(self, col_width=79)
    end

  end

end # module English




=begin
    # Returns a new string with all new lines removed from
    # adjacent lines of text.
    #
    #   s = "This is\na test.\n\nIt clumps\nlines of text."
    #   s.fold
    #
    # _produces_
    #
    #   "This is a test.\n\nIt clumps lines of text. "
    #
    # One arguable flaw with this, that might need a fix:
    # if the given string ends in a newline, it is replaced with
    # a single space.
    #
    #   CREDIT: Trans

    def fold(ignore_indented=false)
      ns = ''
      i = 0
      br = self.scan(/(\n\s*\n|\Z)/m) do |m|
        b = $~.begin(1)
        e = $~.end(1)
        nl = $&
        tx = slice(i...b)
        if ignore_indented and slice(i...b) =~ /^[ ]+/
          ns << tx
        else
          ns << tx.gsub(/[ ]*\n+/,' ')
        end
        ns << nl
        i = e
      end
      ns
    end

    # Returns short abstract of long strings; not exceeding +range+
    # characters. If range is an integer then the minimum is 20%
    # of the maximum. The string is chopped at the nearest word
    # if possible, and appended by +ellipsis+, which defaults
    # to '...'.
    #
    #   CREDIT: George Moschovitis
    #   CREDIT: Trans
    #
    def brief(range=76, ellipsis="...")
      if Range===range
        min = range.first
        max = range.last
      else
        max = range
        min = max - (max/5).to_i
        range = min..max
      end

      if size > max
        cut_at = rindex(/\b/, max) || max
        cut_at = max if cut_at < min
        xstring = slice(0, cut_at)
        xstring.chomp(" ") + ellipsis
      else
        self
      end
    end

    # Filters out words from a string based on block test.
    #
    #   "a string".word_filter { |word| word =~ /^a/ }  #=> "string"
    #
    #   CREDIT: George Moschovitis

    def word_filter( &blk )
      s = self.dup
      s.word_filter!( &blk )
    end

    # In place version of #word_filter.
    #
    #   "a string".word_filter { |word| ... }
    #
    #   CREDIT: George Moschovitis

    def word_filter! #:yield:
      rest_of_string = self
      wordfind = /(\w+)/
      offset = 0
      while wmatch = wordfind.match(rest_of_string)
        word = wmatch[0]
        range = offset+wmatch.begin(0) ... offset+wmatch.end(0)
        rest_of_string = wmatch.post_match
        self[range] = yield( word ).to_s
        offset = self.length - rest_of_string.length
      end
      self
    end

=end

