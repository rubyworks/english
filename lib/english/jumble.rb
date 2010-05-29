require 'english/class'

class English

  # Jumble letter casing.
  #
  #   "superman".jumble  #=> "SUpeRmAn"
  #
  #--
  # TODO: This isn't so much English specific. Maybe it
  # should be deprecated or moved to Langauge?
  #++

  def self.jumble(string)
    j = ''
    string.to_s.split(//).each_with_index{ |c,i| j << ( i % 2 == 0 ? c.downcase : c.upcase ) }
    j
  end

  # Jumble letter casing.
  #
  #   "superman".jumble  #=> "SUpeRmAn"
  #
  def jumble
    self.class.jumble(@self)
  end

end

