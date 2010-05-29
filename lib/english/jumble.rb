#require 'english/classes'

module English

  # Jumble letter casing.
  #
  #   "superman".jumble  #=> "SUpeRmAn"
  #
  #--
  # TODO: This isn't so much English specific. Maybe it
  # should be deprecated or moved to Langauge?
  #++

  def jumble(string)
    j = ''
    string.to_s.split(//).each_with_index{ |c,i| j << ( i % 2 == 0 ? c.downcase : c.upcase ) }
    j
  end

  class String
    # Jumble letter casing.
    #
    #   "superman".jumble  #=> "SUpeRmAn"
    #
    def jumble
      English.jumble(self)
    end
  end

end

