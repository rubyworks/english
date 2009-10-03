require 'english/namecase'
require 'english/en'

class String

  def namecase
    __send__($language|'en').namecase
  end

end

