require 'language/classes'

module English 
  extend Language
  extend self

  # TODO: Probably can make all this dynamic using 'extend Language['en']'.

  #
  class String < Language::String
    def self.language; English; end
  end

  #
  class Integer < Language::Integer
    def self.language; English; end
  end

  #
  class Array < Language::Array
    def self.language; English; end
  end

end

class String
  # Higher-order function to invoke English functions.
  def en
    English::String.instance(self)
  end
end

class Array
  # Higher-order function to invoke English functions.
  def en
    English::Array.instance(self)
  end
end

class Integer
  # Higher-order function to invoke English functions.
  def en
    English::Integer.instance(self)
  end
end

