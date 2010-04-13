require 'english/namecase'
require 'test/unit'

class TC_Namecase < Test::Unit::TestCase

  def setup
    @proper_names = [
      "Keith",            "Leigh-Williams",       "McCarthy",
      "O'Callaghan",      "St. John",             "von Streit",
      "van Dyke",         "Van",                  "ap Llwyd Dafydd",
      "al Fahd",          "Al",
      "el Grecco",
      "ben Gurion",       "Ben",
      "da Vinci",
      "di Caprio",        "du Pont",              "de Legate",
      "del Crond",        "der Sind",             "van der Post",
      "von Trapp",        "la Poisson",           "le Figaro",
      "Mack Knife",       "Dougal MacDonald",
      # Mac exceptions
      "Machin",           "Machlin",              "Machar",
      "Mackle",           "Macklin",              "Mackie",
      "Macquarie",        "Machado",              "Macevicius",
      "Maciulis",         "Macias",               "MacMurdo",
      # Roman numerals
      "Henry VIII",       "Louis III",            "Louis XIV",
      "Charles II",       "Fred XLIX"
    ]
  end

  def test_namecase
    @proper_names.each do |name|
      assert_equal(name, name.namecase)
      assert_equal(name, name.downcase.namecase)
    end
  end

  def test_namecase_modify
    @proper_names.each do |name|
      assert_equal(name, name.namecase)
      assert_equal(name, name.downcase.namecase)
    end
  end

  def test_namecase_multibyte
    $KCODE = 'u'
    proper_cased = 'Iñtërnâtiônàlizætiøn'
    assert_equal(proper_cased, proper_cased.namecase)
    assert_equal(proper_cased, proper_cased.downcase.namecase)
  end
end

#class Test_Case < Test::Unit::TestCase
#
#  def test_titlecase
#    assert_equal('Title Case', 'title case'.titlecase)
#  end
#
#end

