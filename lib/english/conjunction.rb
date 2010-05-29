require 'english/class'

class English

  # English conjunciton.
  #
  # This is more advanced form of #join, as it allows for an
  # English-based terminating separator.
  #
  # The default type of conjunction --the terminating separator,
  # is "and", and the default regualt separator is ",".
  #
  #   [1,2,3].conjunction
  #   => "1, 2 and 3
  #
  #   [1,2,3].conjunction(:or)
  #   => "1, 2 or 3
  #
  #   [1,2,3].conjunction(:or, ';')
  #   => "1; 2 or 3
  #
  #--
  # TODO: Maybe separate into #and, #or and #but ?
  #++

  def self.conjunction(array, type=:and, seperator=",")
    array     = array.to_a
    type      = type.to_s
    separator = separator.to_s
    space     = space.to_s

    case array.length
    when 0
      ""
    when 1
      array[0]
    when 2
      "#{array[0]} #{type} #{array[1]}"
    else
      [array[0..-2].join("#{separator} "), array[-1]].join(" #{type} ")
    end
  end

  # This is more advanced form of #join, as it allows for an
  # English-based terminating separator.
  #
  # The default type of conjunction --the terminating separator,
  # is "and", and the default regualt separator is ",".
  #
  #   [1,2,3].conjunction
  #   => "1, 2 and 3
  #
  #   [1,2,3].conjunction(:or)
  #   => "1, 2 or 3
  #
  #   [1,2,3].conjunction(:or, ';')
  #   => "1; 2 or 3
  #
  def conjunction(type=:and, seperator=",")
    self.class.conjunction(@self, type, separator)
  end

end

