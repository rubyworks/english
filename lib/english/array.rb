module English

  module Array

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
    def conjunction(type=:and, seperator=",")
      type      = type.to_s
      separator = separator.to_s
      space     = space.to_s

      case length
      when 0
        ""
      when 1
        self[0]
      when 2
        "#{self[0]} #{type} #{self[1]}"
      else
        [self[0..-2].join("#{separator} "), self[-1]].join(" #{type} ")
      end
    end

    # Alias for #conjunction.
    alias_method :join_sentence, :conjunction

  end

end


class Array #:nodoc:
  include English::Array
end

