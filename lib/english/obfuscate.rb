module English

  require 'english/class'

  # = Obfuscation
  #
  # The Obfuscate mixin provides a means of applying common
  # scrambling patterns to strings.
  #
  # This module is automatically mixed into the String class, but
  # the mixin is designed in such a way that it can be mixed into
  # any class that supports the #to_s method.
  #
  # Examples
  #
  #   "superman".jumble  #=> "SUpeRmAn"
  #
  module Obfuscate

    # Jumble string.
    #
    #
    def self.jumble(string)
      j = ''
      string.to_s.split(//).each_with_index{ |c,i| j << ( i % 2 == 0 ? c.downcase : c.upcase ) }
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
    # CREDIT: Kurt Dresener
    #
    def self.dresner(string)
      string.to_s.gsub(/\B\w+\B/){$&.split(//).sort_by{rand}}
    end


    def jumble
      Obfuscate.jumble(self)
    end

    def jumble!
      replace(Obfuscate.jumble(self))
    end

    def dresner
      Obfuscate.dresner(self)
    end

    def dresner!
      replace(Obfuscate.dresner(self))
    end

  end

  def self.jumble(string)
    Obfuscate.jumble(string)
  end

  def self.dresner(string)
    Obfuscate.dresner(string)
  end

  class String
    include Obfuscate
  end

end

