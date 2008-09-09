class String

  #

  def join_sentence(sep=nil, last=nil)
    sep  ||= ','
    last ||= 'and'

    sep, last = *[sep, last].collect do |w|
      case w
      when /^\w.*?\w$/
        " #{w} "
      else
        "#{w} "
      end
    end

    seps = [sep] * (size - 1)
    seps[-1] = last
    zip(seps).join
  end

end
