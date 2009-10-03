module English

  require 'english/class'

  #
  def self.vowel?(string)
    /[aeiou]/ix =~ string
  end

  #
  def self.constant?(string)
    /[^aeiou]/ix =~ string
  end


  class String

    #
    def vowel?
      English.vowel?(self)
    end

    #
    def constant?
      English.constant?(self)
    end

  end

end

