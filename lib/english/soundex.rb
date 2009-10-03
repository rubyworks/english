module English

  require 'english/class'

  # Ruby implementation of the Soundex algorithm,
  # as described by Knuth in volume 3 of The Art
  # of Computer Programming.
  #
  # Based on work by Michael Neumann (neumann@s-direktnet.de)
  #
  module Soundex

    # Returns nil if the value couldn't be calculated b/c of
    # empty-string or invalid character.
    #
    #   "Ruby".soundex  #=> "R100"
    #
    def self.soundex(str)
      return nil if str.empty?

      str = str.upcase
      last_code = soundex_code(str[0,1])
      soundex_code = str[0,1]

      for index in 1...(str.size) do
        return soundex_code if soundex_code.size == 4

        code = soundex_code(str[index,1])

        if code == "0" then
          last_code = nil
        elsif code == nil then
          return nil
        elsif code != last_code then
          soundex_code += code
          last_code = code
        end
      end

      return soundex_code + "000"[0,4-soundex_code.size]
    end

    # Support function for String#soundex.
    # Returns code for a single character.
    #
    def self.soundex_code(char)
      char.tr! "AEIOUYWHBPFVCSKGJQXZDTLMNR", "00000000111122222222334556"
    end

    # Mixable version of soundex method.
    #
    def soundex
      Soundex.soundex(to_s)
    end

  end # module Soundex
 
  # English module method for Soundex.
  #
  def self.soundx(string)
    Soundx.soundx(string)
  end

  class String
    #
    def soundex
      Soundex.soundex(self)
    end
  end

end # module English

