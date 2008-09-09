require 'english/inflect'
require 'english/style/case'
require 'english/style/code'
require 'english/style/dresner'
require 'english/style/jumble'
require 'english/style/numeral'
require 'english/style/orm'

module English

  # The Style mixin provides a means of applying common alteration
  # patterns to strings.
  #
  # This module is automatically mixed into the String class, but the
  # Style mixin is designed in such a way that it can be mixed into
  # any class that supports the #to_s method.
  #
  # Examples
  #
  #   "SuperMan".snakecase   #=> "super_man"
  #   "super_man".dasherize  #=> "super-man"
  #
  #
  # TODO: Would like to provide a means for mixing into Symbol
  #       so that Symbols are returned. Use #to_self(obj)?
  #
  module Style
  end

  # TODO: Replace this will dynamic generate of inplace methods.
  #       But only when the base defines #replace (?) Need to
  #       think about this some more.
  module StyleReplace
  end

end

class String #:nodoc:
  include English::Style
  include English::StyleReplace
end

