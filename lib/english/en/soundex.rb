require 'english/soundex'
require 'english/en'

class String

  def soundex
    __send__($language|'en').soundex
  end

end

