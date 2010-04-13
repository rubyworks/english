#
# Examples
#   Stylist.snakecase("CamelCase")    #=> "camel_case"

module Stylist
  private *instance_methods.select{ |a| a !~ /^__|instace_|object_|send/ }

  extend self

  # Replaces underscores with dashes in the string.
  #
  # Example
  #   "puni_puni" #=> "puni-puni"
  def dasherize(underscored_word)
    underscored_word.gsub(/_/, '-')
  end

  # By default, camelize converts strings to UpperCamelCase. If the argument to camelize
  # is set to ":lower" then camelize produces lowerCamelCase.
  #
  # camelize will also convert '/' to '::' which is useful for converting paths to namespaces
  #
  # Examples
  #   "active_record".camelize #=> "ActiveRecord"
  #   "active_record".camelize(:lower) #=> "activeRecord"
  #   "active_record/errors".camelize #=> "ActiveRecord::Errors"
  #   "active_record/errors".camelize(:lower) #=> "activeRecord::Errors"
  def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
    if first_letter_in_uppercase
      lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    else
      lower_case_and_underscored_word.first + camelize(lower_case_and_underscored_word)[1..-1]
    end
  end

  # Capitalizes all the words and replaces some characters in the string to create
  # a nicer looking title. Titleize is meant for creating pretty output. It is not
  # used in the Rails internals.
  #
  # titleize is also aliased as as titlecase
  #
  # Examples
  #   "man from the boondocks".titleize #=> "Man From The Boondocks"
  #   "x-men: the last stand".titleize #=> "X Men: The Last Stand"
  def titleize(word)
    humanize(underscore(word)).gsub(/\b('?[a-z])/) { $1.capitalize }
  end

  # The reverse of +camelize+. Makes an underscored form from the expression in the string.
  #
  # Changes '::' to '/' to convert namespaces to paths.
  #
  # Examples
  #   "ActiveRecord".underscore #=> "active_record"
  #   "ActiveRecord::Errors".underscore #=> active_record/errors
  def snakecase(camel_cased_word)
    camel_cased_word.to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
  alias_method :underscore, :snakecase

  # Replaces underscores with dashes in the string.
  #
  # Example
  #   "puni_puni" #=> "puni-puni"
  def dasherize(underscored_word)
    underscored_word.gsub(/_/, '-')
  end

  # Capitalizes the first word and turns underscores into spaces and strips _id.
  # Like titleize, this is meant for creating pretty output.
  #
  # Examples
  #   "employee_salary" #=> "Employee salary"
  #   "author_id" #=> "Author"
  def humanize(lower_case_and_underscored_word)
    lower_case_and_underscored_word.to_s.gsub(/_id$/, "").gsub(/_/, " ").capitalize
  end

  # Removes the module part from the expression in the string
  #
  # Examples
  #   "ActiveRecord::CoreExtensions::String::Inflections".demodulize #=> "Inflections"
  #   "Inflections".demodulize #=> "Inflections"
  def demodulize(class_name_in_module)
    class_name_in_module.to_s.gsub(/^.*::/, '')
  end

  # Create the name of a table like Rails does for models to table names. This method
  # uses the pluralize method on the last word in the string.
  #
  # Examples
  #   "RawScaledScorer".tableize #=> "raw_scaled_scorers"
  #   "egg_and_ham".tableize #=> "egg_and_hams"
  #   "fancyCategory".tableize #=> "fancy_categories"
  def tableize(class_name)
    pluralize(underscore(class_name))
  end

  # Create a class name from a plural table name like Rails does for table names to models.
  # Note that this returns a string and not a Class. (To convert to an actual class
  # follow classify with constantize.)
  #
  # Examples
  #   "egg_and_hams".classify #=> "EggAndHam"
  #   "posts".classify #=> "Post"
  #
  # Singular names are not handled correctly
  #   "business".classify #=> "Busines"
  def classify(table_name)
    # strip out any leading schema name
    camelize(singularize(table_name.to_s.sub(/.*\./, '')))
  end

  # Creates a foreign key name from a class name.
  # +separate_class_name_and_id_with_underscore+ sets whether
  # the method should put '_' between the name and 'id'.
  #
  # Examples
  #   "Message".foreign_key #=> "message_id"
  #   "Message".foreign_key(false) #=> "messageid"
  #   "Admin::Post".foreign_key #=> "post_id"
  def foreign_key(class_name, separate_class_name_and_id_with_underscore = true)
    underscore(demodulize(class_name)) + (separate_class_name_and_id_with_underscore ? "_id" : "id")
  end

  # Converts a string into a unix path.
  # This method is geared toward code reflection.
  #
  # See : String#modulize, String#methodize
  #
  #   "MyModule::MyClass".pathize   #=> my_module/my_class
  #   "my_module__my_class".pathize #=> my_module/my_class
  #
  # TODO:
  #   * Make sure that all scenarios return a valid unix path
  #   * Make sure it is revertible
  def pathize
    to_s.gsub(/([A-Z])/, '_\1').downcase.gsub(/^_/,'').gsub(/(::|__)_?/, '/')
  end

  # Converts a string into a valid ruby method name
  # This method is geared toward code reflection.
  #
  #   "MyModule::MyClass".methodize  #=> "my_module__my_class"
  #
  # See also String#modulize, String#pathize
  #
  # TODO: Make sure methodize is reversable (?)
  def methodize
    to_s.gsub(/([A-Z])/, '_\1').downcase.gsub(/^_/,'').gsub(/(::|\/)_?/, '__')
  end

  # Converts a string into a valid ruby class or module name
  # This method is geared toward code reflection.
  #
  #   "my_module__my_path".modulize  #=> "MyModule::MyPath"
  #
  # See also String#methodize, String#pathize
  #
  #
  # TODO: Make sure moduleize that all scenarios return a valid ruby class name
  def modulize
    to_s.gsub(/(__|\/)(.?)/){ "::" + $2.upcase }.gsub(/(^|_)(.)/){ $2.upcase }
  end

end


class Class

  # Translate a class name to a suitable method name.
  #
  #   My::CoolClass.methodize => "my__cool_class"
  #
  def methodize
    name.gsub(/([A-Z]+)([A-Z])/,'\1_\2').gsub(/([a-z])([A-Z])/,'\1_\2').gsub('::','__').downcase
  end

  # Converts a class name to a unix path
  #
  #   My::CoolClass.pathize  #=> "/my/cool_class"
  #
  def pathize
    '/' + name.gsub(/([A-Z]+)([A-Z])/,'\1_\2').gsub(/([a-z])([A-Z])/,'\1_\2').gsub('::','/').downcase
  end

end


