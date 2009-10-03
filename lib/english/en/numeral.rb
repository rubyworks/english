require 'english/numeral'
require 'english/en'

class String

  #
  def ordinal
    __send__($language || 'en').ordinal
  end

  #
  def numeral
    __send__($language || 'en').numeral
  end

end


class Integer

  #
  def ordinal
    __send__($language || 'en').ordinal
  end

  #
  def numeral
    __send__($language || 'en').numeral
  end

end

