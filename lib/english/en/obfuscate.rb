require 'english/obfuscate'
require 'english/en'

class String

  #
  def jumble
    __send__($language || 'en').jumble
  end

  #
  def dresner
    __send__($language || 'en').dresner
  end

end
