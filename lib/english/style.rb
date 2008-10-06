module English
  #require 'english/inflect'

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
  #--
  # TODO: With #pathize, is downcasing really needed? After all paths
  #       can have capitalize letters ;p
  #
  # TODO: With #methodize, is downcasing any but the first letter
  #       really needed? Desipite Matz preference methods can have
  #       capitalized letters.
  #++
  module Style

    # Case Styles
    # ______________________________________________________________

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
    def uncapitalize
      str = to_s
      str[0,1].downcase + str[1..-1]
    end
    alias_method :uncapitalcase, :uncapitalize

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
      upper_camelcase.uncapitalize
    end

    # Returns a new +String+ with the contents properly namecased.
    #--
    # Perl Version Copyright (c) Mark Summerfield 1998-2002
    # <summer@perlpress.com>
    #
    # Ruby Version:
    # Copyright (c) Aaron Patterson 2006
    #++
    def namecase
      localstring = downcase
      localstring.gsub!(/\b\w/) { |first| first.upcase }
      localstring.gsub!(/\'\w\b/) { |c| c.downcase } # Lowercase 's

      # Fixes for "Mac".
      if localstring =~ /\bMac[A-Za-z]{2,}[^aciozj]\b/ or localstring =~ /\bMc/
        localstring.gsub!(/\b(Ma?c)([A-Za-z]+)/) { |match| $1 + $2.capitalize }
        localstring.gsub!(/\bMacEvicius/, 'Macevicius')
        localstring.gsub!(/\bMacHado/, 'Machado')
        localstring.gsub!(/\bMacHar/, 'Machar')
        localstring.gsub!(/\bMacHin/, 'Machin')
        localstring.gsub!(/\bMacHlin/, 'Machlin')
        localstring.gsub!(/\bMacIas/, 'Macias')
        localstring.gsub!(/\bMacIulis/, 'Maciulis')
        localstring.gsub!(/\bMacKie/, 'Mackie')
        localstring.gsub!(/\bMacKle/, 'Mackle')
        localstring.gsub!(/\bMacKlin/, 'Macklin')
        localstring.gsub!(/\bMacQuarie/, 'Macquarie')
      end
      localstring.gsub!('Macmurdo','MacMurdo')

      # Fixes for "son (daughter) of" etc.
      localstring.gsub!(/\bAl(?=\s+\w)/, 'al')      # al Arabic or forename Al.
      localstring.gsub!(/\bAp\b/, 'ap')             # ap Welsh.
      localstring.gsub!(/\bBen(?=\s+\w)/,'ben')     # ben Hebrew or forename Ben.
      localstring.gsub!(/\bDell([ae])\b/,'dell\1')  # della and delle Italian.
      localstring.gsub!(/\bD([aeiu])\b/,'d\1')      # da, de, di Italian; du French.
      localstring.gsub!(/\bDe([lr])\b/,'de\1')      # del Italian; der Dutch/Flemish.
      localstring.gsub!(/\bEl\b/,'el')              # el Greek or El Spanish.
      localstring.gsub!(/\bLa\b/,'la')              # la French or La Spanish.
      localstring.gsub!(/\bL([eo])\b/,'l\1')        # lo Italian; le French.
      localstring.gsub!(/\bVan(?=\s+\w)/,'van')     # van German or forename Van.
      localstring.gsub!(/\bVon\b/,'von')            # von Dutch/Flemish

      # Fix roman numeral names
      localstring.gsub!(
        / \b ( (?: [Xx]{1,3} | [Xx][Ll]   | [Ll][Xx]{0,3} )?
               (?: [Ii]{1,3} | [Ii][VvXx] | [Vv][Ii]{0,3} )? ) \b /x
      ) { |match| match.upcase }

      localstring
    end

    # Numeral Styles
    # ______________________________________________________________

    # Ordinalize turns a number string into an ordinal string
    # used to denote the position in an ordered sequence such
    # as 1st, 2nd, 3rd, 4th.
    #
    #   '1'.ordinalize     # => "1st"
    #   '2'.ordinalize     # => "2nd"
    #   '1002'.ordinalize  # => "1002nd"
    #   '1003'.ordinalize  # => "1003rd"
    #
    def ordinalize
      number_string = to_s
      if number_string =~ /\d{1,2}$/
        number = $1.to_i     
        if (11..13).include?(number.to_i % 100)
          r = "#{number}th"
        else
          r = case number.to_i % 10
            when 1; "#{number}st"
            when 2; "#{number}nd"
            when 3; "#{number}rd"
            else    "#{number}th"
          end
        end
        number_string.sub(/\d{1,2}$/, r)
      else
        number_string
      end
    end

    #
    # Obfuscation Styles
    #______________________________________________________________

    # Jumble string.
    def jumble
      j = ''
      to_s.split(//).each_with_index{ |c,i| j << ( i % 2 == 0 ? c.downcase : c.upcase ) }
      j
    end

    # Dresener Obfuscation.
    #
    # Scramble the inner characters of words leaving the text still readable
    # (research at Cambridge University, code by KurtDresner).
    #
    # For example, the above text may result in:
    #
    #   Srblamce the iennr cchrteaars of wodrs lvenaig the txet stlil rbeaadle
    #   (rreceash at Cbamigdre Uverintisy, cdoe by KrneruestDr?)
    #
    # :credit: Kurt Dresener
    def dresner
      to_s.gsub(/\B\w+\B/){$&.split(//).sort_by{rand}}
    end

    #
    # Code Styles
    # ______________________________________________________________

    # Converts a module or method name into a unix pathname.
    # This method is geared toward code reflection.
    #
    #   "MyModule::MyClass".pathize    #=> my_module/my_class
    #   "my_module__my_class".pathize  #=> my_module/my_class
    #
    # TODO: Make sure that all scenarios return a valid unix path.
    # TODO: Make sure it is revertible.
    #
    # See also #modulize, #methodize
    def pathize
      to_s.
      gsub(/__/, '/').
      gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

    # Converts a module name into a valid method name.
    # This method is geared toward code reflection.
    #
    # Examples
    #   "SuperMan".methodize          #=> "super_man"
    #   "SuperMan::Errors".methodize  #=> "super_man__errors
    #   "MyModule::MyClass".methodize #=> "my_module__my_class"
    #
    # See also #modulize, #pathize
    def methodize
      to_s.
      gsub(/\//, '__').
      gsub(/::/, '__').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

    # Converts a pathized or methodized string into a valid ruby
    # class or module name. This method is geared toward code
    # reflection.
    #
    #   "camel_case".modulize          #=> "CamelCase"
    #   "camel/case".modulize          #=> "Camel::Case"
    #   "my_module__my_path".modulize  #=> "MyModule::MyPath"
    #
    # See also #methodize, #pathize
    def modulize
      to_s.
      gsub(/__(.?)/){ "::#{$1.upcase}" }.
      gsub(/\/(.?)/){ "::#{$1.upcase}" }.
      gsub(/(?:_+)([a-z])/){ $1.upcase }.
      gsub(/(^|\s+)([a-z])/){ $1 + $2.upcase }
    end

    # Removes the module part from a modularized expression.
    #
    #   "English::Style".demodulize  #=> "Style"
    #   "Style".demodulize           #=> "Style"
    #
    #def demodulize
    #  to_s.gsub(/^.*::/, '')
    #end

  end

  # TODO: Replace this will dynamic generate of inplace methods.
  #       But only when the base defines #replace (?) Need to
  #       think about this some more.
  module Style::Replace
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
    def namecase!      ; replace(namecase)      ; end

    def ordinalize!    ; replace(ordinalize)    ; end

    def jumble!        ; replace(jumble)        ; end
    def dresner!       ; replace(dresner)       ; end

    def pathize!       ; replace(pathize)       ; end
    def methodize!     ; replace(methodize)     ; end
    def modulize!      ; replace(modulize)      ; end
  end

end

class String #:nodoc:
  include English::Style
  include English::Style::Replace
end

