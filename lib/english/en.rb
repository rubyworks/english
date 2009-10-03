#require 'english/class'

module English
end

$language ||= 'en'

class String

  # Higher-order function to invoke English functions
  # for current string.
  #--
  # TODO: Use Functor.instance for future version.
  #++
  def en
    English::String.instance(self)
  end

end

class Array

  # Higher-order function to invoke English functions
  # for current string.
  #--
  # TODO: Use Functor.instance for future version.
  #++
  def en
    English::Array.instance(self)
  end

end

