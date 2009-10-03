require 'english/general'
require 'english/en'

class String

  def vowel?
    __send__($language|'en').vowel?
  end

  def constant?
    __send__($language|'en').vowel?
  end

end

