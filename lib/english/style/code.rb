module English

  #--
  # TODO: With #pathize, is downcasing really needed? After all paths
  #       can have capitalize letters ;p
  #
  # TODO: With #methodize, is downcasing any but the first letter
  #       really needed? Desipite Matz prefernce methods can have
  #       capitalized letters.
  #++

  module Style
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
    def demodulize
      to_s.gsub(/^.*::/, '')
    end
  end

  module StyleReplace
    def pathize!    ; replace(pathize)    ; end
    def methodize!  ; replace(methodize)  ; end
    def modulize!   ; replace(modulize)   ; end
    def demodulize! ; replace(demodulize) ; end
  end

end

class String #:nodoc:
  include English::Style
  include English::StyleReplace
end

