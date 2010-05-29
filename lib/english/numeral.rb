require 'english/class'

class English

  ONES = %w[ zero one two three four five six seven eight nine ]

  TEEN = %w[ ten eleven twelve thirteen fourteen fifteen
            sixteen seventeen eighteen nineteen ]

  TENS = %w[ zero ten twenty thirty forty fifty
            sixty seventy eighty ninety ]

  MEGA = %w[ none thousand million billion ]

  # Convert an integer to the english spelling of that number.
  def self.numeral(integer)
    places = integer.to_i.to_s.split(//).collect{|s| s.to_i}.reverse
    name = []
    ((places.length + 2) / 3).times do |p|
      strings = trio(places[p * 3, 3])
      name.push(MEGA[p]) if strings.length > 0 and p > 0
      name += strings
    end
    name.push(ONES[0]) unless name.length > 0
    name.reverse.join(" ")
  end

  #
  def self.trio(places)
    strings = []
    if places[1] == 1
      strings.push(TEEN[places[0]])
    elsif places[1] and places[1] > 0
      strings.push(places[0] == 0 ? TENS[places[1]] : "#{TENS[places[1]]}-#{ONES[places[0]]}")
    elsif places[0] > 0
      strings.push(ONES[places[0]])
    end
    if places[2] and places[2] > 0
      strings.push("hundred", ONES[places[2]])
    end
    strings
  end

  # Convert to the english spelling of a number.
  #
  #   10.numeral  #=> "10"
  #
  def numeral
    self.class.numeral(@self)
  end

  # Credit goes to Glenn P. Parker
  #
  # TODO: Get English#numeral to handle decicmal fractions.
  #
  # TODO: Get English#numeral to handle larger groups of thousands.

end

