require 'english/conjunction'
require 'english/en'

class Array

  def conjunction(type=:and, seperator=",")
    __send__($langauge || 'en').conjunction(type, seperator)
  end

end

