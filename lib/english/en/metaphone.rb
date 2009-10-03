require 'english/metaphone'
require 'english/en'

class String

  def metaphone(alt=nil)
    __send__($langauge || 'en').metaphone(alt)
  end

  def double_metaphone
    __send__($langauge || 'en').double_metaphone
  end

end

