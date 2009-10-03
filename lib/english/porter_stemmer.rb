module English

  # An implementaion of the Porter Stemming algorithm by Martin Porter.
  #
  # This is the Porter Stemming algorithm, ported to Ruby from the
  # version coded up in Perl. It's easy to follow against the rules
  # in the original paper in:
  #
  #   Porter, 1980, An algorithm for suffix stripping, Program, Vol. 14,
  #   no. 3, pp 130-137,
  #
  # Taken from http://www.tartarus.org/~martin/PorterStemmer (Public Domain)
  #
  # This version based on Ray Pereda's stemmable.rb (c) 2003.
  #
  module PorterStemmer

    PORTER_STEMS = []

    PORTER_STEMS[0] = {
      'ational' => 'ate', 'tional' => 'tion', 'enci' => 'ence', 'anci' => 'ance',
      'izer' => 'ize', 'bli' => 'ble',
      'alli' => 'al', 'entli' => 'ent', 'eli' => 'e', 'ousli' => 'ous',
      'ization' => 'ize', 'ation' => 'ate',
      'ator' => 'ate', 'alism' => 'al', 'iveness' => 'ive', 'fulness' => 'ful',
      'ousness' => 'ous', 'aliti' => 'al',
      'iviti' => 'ive', 'biliti' => 'ble', 'logi' => 'log'
    }

    PORTER_STEMS[1] = {
      'icate' => 'ic', 'ative' => '', 'alize' => 'al', 'iciti' => 'ic',
      'ical' => 'ic', 'ful' => '', 'ness' => ''
    }


    PORTER_STEMS_RE = []

    PORTER_STEMS_RE[0] = Regexp.new(PORTER_STEMS[0].keys.join('|'), Regexp::EXTENDED)

    PORTER_STEMS_RE[1] = Regexp.new(PORTER_STEMS[1].keys.join('|'), Regexp::EXTENDED)

    PORTER_STEMS_RE[2] = /(
                          al       |
                          ance     |
                          ence     |
                          er       |
                          ic       |
                          able     |
                          ible     |
                          ant      |
                          ement    |
                          ment     |
                          ent      |
                          ou       |
                          ism      |
                          ate      |
                          iti      |
                          ous      |
                          ive      |
                          ize)$/x

    C = "[^aeiou]"             # consonant
    V = "[aeiouy]"             # vowel
    CC = "#{C}(?>[^aeiouy]*)"  # consonant sequence
    VV = "#{V}(?>[aeiou]*)"    # vowel sequence

    MGR0 = /^(#{CC})?#{VV}#{CC}/o                # [cc]vvcc... is m>0
    MEQ1 = /^(#{CC})?#{VV}#{CC}(#{VV})?$/o       # [cc]vvcc[vv] is m=1
    MGR1 = /^(#{CC})?#{VV}#{CC}#{VV}#{CC}/o      # [cc]vvccvvcc... is m>1

    VOWEL_IN_STEM = /^(#{CC})?#{V}/o             # vowel in stem

    def self.stem(word)

      # make a copy of the given object and convert it to a string.
      word = word.dup.to_str

      return word if word.length < 3

      # now map initial y to Y so that the patterns never treat it as vowel
      word[0] = 'Y' if word[0] == ?y

      # Step 1a
      if word =~ /(ss|i)es$/
        word = $` + $1
      elsif word =~ /([^s])s$/
        word = $` + $1
      end

      # Step 1b
      if word =~ /eed$/
        word.chop! if $` =~ MGR0
      elsif word =~ /(ed|ing)$/
        stem = $`
        if stem =~ VOWEL_IN_STEM
          word = stem
          case word
            when /(at|bl|iz)$/             then word << "e"
            when /([^aeiouylsz])\1$/       then word.chop!
            when /^#{CC}#{V}[^aeiouwxy]$/o then word << "e"
          end
        end
      end

      if word =~ /y$/
        stem = $`
        word = stem + "i" if stem =~ VOWEL_IN_STEM
      end

      # Step 2
      if word =~ PORTER_STEMS_RE[0]
        stem = $`
        suffix = $1
        # print "stem= " + stem + "\n" + "suffix=" + suffix + "\n"
        if stem =~ MGR0
          word = stem + PORTER_STEM[0][suffix]
        end
      end

      # Step 3
      if word =~ PORTER_STEMS_RE[1]
        stem = $`
        suffix = $1
        if stem =~ MGR0
          word = stem + PORTER_STEMS[1][suffix]
        end
      end

      # Step 4
      if word =~ PORTER_STEMS_RE[2]
        stem = $`
        if stem =~ MGR1
          word = stem
        end
      elsif word =~ /(s|t)(ion)$/
        stem = $` + $1
        if stem =~ MGR1
          word = stem
        end
      end

      #  Step 5
      if word =~ /e$/
        stem = $`
        if (stem =~ MGR1) ||
            (stem =~ MEQ1 && stem !~ /^#{CC}#{V}[^aeiouwxy]$/o)
          word = stem
        end
      end

      if word =~ /ll$/ && word =~ MGR1
        word.chop!
      end

      # and turn initial Y back to y
      word[0] = 'y' if word[0] == ?Y

      word
    end

    #
    def stem_porter
      PorterStemmer.stem(to_s)
    end

  end

  #
  def self.stem_porter(string)
    PorterStemmer.stem(string)
  end

  class String
    #
    def stem_porter
      PorterStemmer.stem(self)
    end
  end

end

