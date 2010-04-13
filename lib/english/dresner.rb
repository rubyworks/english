require 'english/classes'

module English

  # Scramble the inner characters of words leaving the text still readable
  # (research at Cambridge University, code by KurtDresner).
  #
  # For example, the above text may result in:
  #
  #   Srblamce the iennr cchrteaars of wodrs lvenaig the txet stlil rbeaadle
  #   (rreceash at Cbamigdre Uverintisy, cdoe by KrneruestDr?)
  #
  # CREDIT: Kurt Dresener

  def dresner(string)
    string.to_s.gsub(/\B\w+\B/){$&.split(//).sort_by{rand}}
  end

  class String
    # Scramble the inner characters of words leaving the text still readable
    # (research at Cambridge University, code by KurtDresner).
    #
    # For example, the above text may result in:
    #
    #   Srblamce the iennr cchrteaars of wodrs lvenaig the txet stlil rbeaadle
    #   (rreceash at Cbamigdre Uverintisy, cdoe by KrneruestDr?)
    #
    # CREDIT: Kurt Dresener
    def dresner
      language.dresner(self)
    end
  end

end
