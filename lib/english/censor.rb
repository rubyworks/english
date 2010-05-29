require 'language/censor'

class English

  def self.dirty_words
    %w{fuck shit cunt pussy dick asshole niger}
  end

  class Censor < Language::Censor
    #
    def self.default_words
      English.dirty_words
    end
  end

end
