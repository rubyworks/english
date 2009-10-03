require 'english/inflect'
require 'english/en'

class String

  #
  def singular
    __send__($language || 'en').singular
  end

  #
  alias_method(:singularize, :singular)

  #
  def plural
    __send__($language || 'en').plural
  end

  #
  alias_method(:pluralize, :plural)

end
