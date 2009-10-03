require 'facets/functor'

require 'english/censor'
require 'english/conjunction'
require 'english/inflect'
require 'english/metaphone'
require 'english/namecase'
require 'english/numerals'
require 'english/obfuscate'
require 'english/ordinal'
require 'english/patterns'
require 'english/porter_stemmer'
require 'english/soundex'
require 'english/stylize'
require 'english/words'

class String

  def en
    Functor.new do |op, *a, &b|
      English.send(op, self, *a, &b)
    end
  end

end
