module English #:nodoc:

  module Style
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
    def dresner
      to_s.gsub(/\B\w+\B/){$&.split(//).sort_by{rand}}
    end
  end

  module StyleReplace
    # In place version of the #dresner method.
    def dresner!
      replace(dresner)
    end
  end

end

class String #:nodoc:
  include English::Style
  include English::StyleReplace
end

# :credit: Kurt Dresener

