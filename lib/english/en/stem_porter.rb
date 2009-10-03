require 'english/porter_stemmer'
require 'english/en'

class String

  def stem_porter
    __send__($language|'en').stem_porter
  end

end

