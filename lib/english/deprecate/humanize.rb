warn "English::Humanize is being deprecated."

module English
  require 'english/inflect'
  require 'english/stylize'

  # = String Humanization
  #
  # == WARNING: This module is being deprecated. It's use is geared toward ORMs which can define their own if needed.
  #
  # Transform strings into human readable forms. Used for ORM.
  #
  module Humanize

    #########################################################
    # ACTIVE SUPPORT                                        #
    #                                                       #
    # The following were extracted from ActiveSupport's     #
    # Inflector class. It seemed prudent to maintian this   #
    # degree of compatbility, at least for the time being.  #
    #########################################################

    # By default, camelize converts strings to UpperCamelCase. If the
    # argument to camelize is set to ":lower" then camelize produces
    # lowerCamelCase.
    #
    # camelize will also convert '/' to '::' which is useful for
    # converting paths to namespaces
    #
    #   "active_record".camelize               #=> "ActiveRecord"
    #   "active_record".camelize(true)         #=> "activeRecord"
    #   "active_record/errors".camelize        #=> "ActiveRecord::Errors"
    #   "active_record/errors".camelize(true)  #=> "activeRecord::Errors"
    #
    def camelize(first_letter_in_uppercase = true)
      if first_letter_in_uppercase
        to_s.gsub(/\/(.?)/){ "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/){ $1.upcase }
      else
        lowercase_and_underscored = to_s
        lowercase_and_underscored[0,1] + lowercase_and_underscored.camelize[1..-1]
      end
    end

    # Removes the module part from a modularized expression.
    #
    #   "English::Style".demodulize  #=> "Style"
    #   "Style".demodulize           #=> "Style"
    #
    # NOTE: This comes from ActiveSupport. The name of this
    #       method blows. Think of a better one, please.
    def demodulize
      to_s.gsub(/^.*::/, '')
    end

    # Create a class name from a plural table name like Rails does
    # for table names to models. Note that this returns a string and
    # not a Class. (To convert to an actual class follow classify
    # with constantize.)
    #
    #   "egg_and_hams".classify  #=> "EggAndHam"
    #   "posts".classify         #=> "Post"
    #
    # Singular names are not handled correctly:
    #
    #   "business".classify      #=> "Busines"
    #
    def classify
      # strip out any leading schema name
      to_s.sub(/.*\./, '').singularize.camelize
    end

    # Capitalizes the first word and turns underscores into spaces and strips _id.
    # Like titleize, this is meant for creating pretty output.
    #
    #   "employee_salary".humanize    #=> "Employee salary"
    #   "author_id".humanize          #=> "Author"
    #
    def humanize
      to_s.gsub(/_id$/, "").gsub(/_/, " ").capitalize
    end

    # Create the name of a table like Rails does for models to table names.
    # This method uses the pluralize method on the last word in the string.
    #
    #   "RawScaledScorer".tableize  #=> "raw_scaled_scorers"
    #   "egg_and_ham".tableize      #=> "egg_and_hams"
    #   "fancyCategory".tableize    #=> "fancy_categories"
    #
    def tableize
      to_s.underscore.pluralize
    end

    # Capitalizes all the words and replaces some characters in the
    # string to create a nicer looking title. Titleize is meant for
    # creating pretty output. It is not used in the Rails internals.
    #
    # titleize is also aliased as as titlecase
    #
    #   "man from the boondocks".titleize   #=> "Man From The Boondocks"
    #   "x-men: the last stand".titleize    #=> "X Men: The Last Stand"
    #
    def titleize
      to_s.underscore.humanize.gsub(/\b('?[a-z])/){ $1.capitalize }
    end

    # Creates a foreign key name from a class name.
    # +separate_id_with_underscore+ sets whether the method
    # should put '_' between the name and 'id'.
    #
    #   "Message".foreign_key        #=> "message_id"
    #   "Message".foreign_key(false) #=> "messageid"
    #   "Admin::Post".foreign_key    #=> "post_id"
    #
    def foreign_key(separate_id_with_underscore = true)
      to_s.demodulize.underscore + (separate_id_with_underscore ? "_id" : "id")
    end

    # Include Replace mixin if base class/module supports #replace method.
    def self.included(base)
      if base.instance_methods.include?('replace') or
         base.instance_methods.include?(:replace) # Ruby 1.9
        base.module_eval{ include Replace }
      end
    end

    module Replace
      def camelize!    ; replace(camelize)    ; end
      def demodulize!  ; replace(demodulize) ; end
      def classify!    ; replace(classify)    ; end
      def humanize!    ; replace(humanize)    ; end
      def tableize!    ; replace(tableize)    ; end
      def titleize!    ; replace(titleize)    ; end
      def foreign_key! ; replace(foreign_key) ; end
    end

  end

end

class String #:nodoc:
  include English::Humanize
end

