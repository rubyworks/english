require 'english/structure'
require 'english/en'

class String

  #
  def words(&blk)
    __send__($language|'en').words(&blk)
  end

  #
  def each_word(&blk)
    __send__($language|'en').each_word(&blk)
  end

  #
  def sentences(&blk)
    __send__($language|'en').sentences(&blk)
  end

  #
  def each_sentences(&blk)
    __send__($language|'en').each_sentence(&blk)
  end

  #
  def paragraphs(&blk)
    __send__($language|'en').paragraphs(&blk)
  end

  #
  def each_paragraphs(&blk)
    __send__($language|'en').each_paragraph(&blk)
  end

  #
  def word_wrap(col_width=79)
    __send__($language|'en').word_wrap(&blk)
  end

  #
  def word_wrap!(col_width=79)
    __send__($language|'en').word_wrap!(&blk)
  end

end

