module English

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

  #
  def ordinal
    English.ordinal(self)
  end

end

