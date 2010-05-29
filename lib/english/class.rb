require 'language/class'

class English < Language
  #
  def self.abbreviation
    'en'
  end
end

class String
  # Higher-order function to invoke English functions.
  def en
    English.instance(self)
  end
end

class Array
  # Higher-order function to invoke English functions.
  def en
    English.instance(self)
  end
end

class Integer
  # Higher-order function to invoke English functions.
  def en
    English.instance(self)
  end
end

