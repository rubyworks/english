module English

  # This is more advnaced form of #join. It allows for a different
  # terminating separator.
  #
  # The default type of conjunction --the terminating separator, is "and", and
  # the default regualt separator is ",".
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

  class << self
    # Alias for #conjunction.
    alias_method :join_sentence, :conjunction
  end

end

#class Array
#  include English::Array
#end

