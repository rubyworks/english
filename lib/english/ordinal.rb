require 'english/class'

class English

  # Ordinalize turns a number string into an ordinal string
  # used to denote the position in an ordered sequence such
  # as 1st, 2nd, 3rd, 4th.
  #
  #   English.ordinal('1')  #=> "1st"
  #   English.ordinal('2')  #=> "2nd"
  #   English.ordinal(102)  #=> "102nd"
  #   English.ordinal(103)  #=> "103rd"
  #
  def self.ordinal(number)
    number_string = number.to_s.strip
    if md = /\d{1,2}$/.match(number_string)
      n = md[0].to_i
      if (11..13).include?(number.to_i % 100)
        "#{number}th"
      else
        case n % 10
          when 1; "#{number}st"
          when 2; "#{number}nd"
          when 3; "#{number}rd"
          else    "#{number}th"
        end
      end      
      #number_string.sub(/\d{1,2}$/, r)
    else
      number_string
    end
  end

  # Ordinalize turns a number string into an ordinal string
  # used to denote the position in an ordered sequence such
  # as 1st, 2nd, 3rd, 4th.
  #
  #   '1'.ordinal     # => "1st"
  #   '2'.ordinal     # => "2nd"
  #   '102'.ordinal   # => "102nd"
  #   '103'.ordinal   # => "103rd"
  #
  #   1.ordinal       # => "1st"
  #   2.ordinal       # => "2nd"
  #   102.ordinal     # => "102nd"
  #   103.ordinal     # => "103rd"
  #
  def ordinal
    self.class.ordinal(@self)
  end

end

