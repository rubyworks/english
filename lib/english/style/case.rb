module English #:nodoc:

  module Style

    # Standard downcase style.
    def downcase
      to_s.downcase
    end

    # Same as downcase style.
    def lowercase
      to_s.downcase
    end

    # Standard upcase style.
    def upcase
      to_s.upcase
    end

    # Same as upcase style.
    def uppercase
      to_s.upcase
    end

    # Standard capitialize style.
    #
    # NOTE: I hate this definition and think it
    #       should be as capitalcase, but Matz
    #       doesn't agree.
    def capitalize
      to_s.capitalize
    end

    # Upcase first letter.
    def capitalcase
      str = to_s
      str[0,1].upcase + str[1..-1]
    end

    # Downcase first letter.
    def uncapitalcase
      str = to_s
      str[0,1].downcase + str[1..-1]
    end

    # Convert a phrase into a title.
    #
    #   "this is a string".titlecase
    #   => "This Is A String"
    #
    def titlecase
      to_s.gsub(/\b\w/){$&.upcase}
    end

    # The reverse of +camelize+. Converts a CamelCase word into an
    # underscored form.
    #
    # This also changes '::' to '/', usefule for converting namespaces
    # to pathnames.
    #
    # Examples
    #   "ActiveRecord".underscore #=> "active_record"
    #   "ActiveRecord::Errors".underscore #=> active_record/errors
    #
    def snakecase
      to_s.
      gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

    # By default, camelize converts strings to UpperCamelCase. If the
    # argument to camelize is set to ":lower" then camelize produces
    # lowerCamelCase.
    #
    # camelize will also convert '/' to '::' which is useful for
    # converting paths to namespaces
    #
    #   "active_record".camelcase               #=> "ActiveRecord"
    #   "active_record/errors".camelcase        #=> "ActiveRecord::Errors"
    #
    def camelcase
      to_s.gsub(/\/(.?)/){ "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/){ $1.upcase }
    end

    # Convert a snakecase phrase into a camelcase phrase, making
    # the first letter uppercase.
    #def upper_camelcase
    #  to_s.gsub(/\/(.?)/){ "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/){ $1.upcase }
    #end

    # Convert a snakecase phrase into a camelcase phrase, but making
    # the first letter lowercase.
    #
    #   "active_record".camelcase               #=> "activeRecord"
    #   "active_record/errors".camelcase        #=> "activeRecord::Errors"
    #
    def subcamelcase
      upper_camelcase.uncapital
    end
  end

  module StyleReplace
    def downcase!      ; replace(downcase)      ; end
    def lowercase!     ; replace(lowercase)     ; end
    def upcase!        ; replace(upcase)        ; end
    def uppercase!     ; replace(uppercase)     ; end
    def capitalize!    ; replace(capitalize)    ; end
    def capitalcase!   ; replace(capitalcase)   ; end
    def uncapitalcase! ; replace(uncapitalcase) ; end
    def titlecase!     ; replace(titlecase)     ; end
    def snakecase!     ; replace(snakecase)     ; end
    def camelcase!     ; replace(camelcase)     ; end
    def subcamelcase!  ; replace(subcamelcase)  ; end
  end

end

class String #:nodoc:
  include English::Style
  include English::StyleReplace
end


