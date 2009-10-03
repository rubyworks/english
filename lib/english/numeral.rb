module English

  # Numeral.name by Glenn P. Parker
  #
  module Numeral

    # Ordinalize turns a number string into an ordinal string
    # used to denote the position in an ordered sequence such
    # as 1st, 2nd, 3rd, 4th.
    #
    #   '1'.ordinalize     # => "1st"
    #   '2'.ordinalize     # => "2nd"
    #   '1002'.ordinalize  # => "1002nd"
    #   '1003'.ordinalize  # => "1003rd"
    #
    def self.ordinal(number)
      number_string = number.to_s
      if number_string =~ /\d{1,2}$/
        number = $1.to_i
        if (11..13).include?(number.to_i % 100)
          r = "#{number}th"
        else
          r = case number.to_i % 10
            when 1; "#{number}st"
            when 2; "#{number}nd"
            when 3; "#{number}rd"
            else    "#{number}th"
          end
        end
        number_string.sub(/\d{1,2}$/, r)
      else
        number_string
      end
    end

    Ones = %w[ zero one two three four five six seven eight nine ]

    Teen = %w[ ten eleven twelve thirteen fourteen fifteen
              sixteen seventeen eighteen nineteen ]

    Tens = %w[ zero ten twenty thirty forty fifty
              sixty seventy eighty ninety ]

    Mega = %w[ none thousand million billion ]

    # Convert an integer to the english spelling of that number.

    def self.name(integer)
      places = integer.to_i.to_s.split(//).collect{|s| s.to_i}.reverse
      name = []
      ((places.length + 2) / 3).times do |p|
        strings = Numerals.trio(places[p * 3, 3])
        name.push(Mega[p]) if strings.length > 0 and p > 0
        name += strings
      end
      name.push(Ones[0]) unless name.length > 0
      name.reverse.join(" ")
    end

  private

    def self.trio(places)
      strings = []
      if places[1] == 1
        strings.push(Teen[places[0]])
      elsif places[1] and places[1] > 0
        strings.push(places[0] == 0 ? Tens[places[1]] :
                    "#{Tens[places[1]]}-#{Ones[places[0]]}")
      elsif places[0] > 0
        strings.push(Ones[places[0]])
      end
      if places[2] and places[2] > 0
        strings.push("hundred", Ones[places[2]])
      end
      strings
    end

  end

  #
  def self.ordinal(integer)
    Numerals.ordinal(integer)
  end

  #
  def self.numeral(integer)
    Numerals.name(integer)
  end

  class String
    def ordinal
      English.ordinal(self)
    end
    def numeral
      English::Numerals.name(self)
    end
  end

  class Integer
    def ordinal
      English.ordinal(self)
    end
    def numeral
      English::Numerals.name(self)
    end
  end

end # module English

