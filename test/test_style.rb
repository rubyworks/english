require 'english/style'
require 'test/unit'

#$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
#$:.unshift File.join(File.dirname(__FILE__), "..", "test")

class Test_Style < Test::Unit::TestCase

  #def test_camelize
  #  assert_equal( 'ThisIsIt', 'this_is_it'.camelize )
  #end

  #def test_humanize
  #  assert_equal( 'This is it', 'this_is_it'.humanize )
  #end

  def test_modulize
    assert_equal( 'MyModule::MyClass',   'my_module__my_class'.modulize   )
    assert_equal( '::MyModule::MyClass', '__my_module__my_class'.modulize )
    assert_equal( 'MyModule::MyClass',   'my_module/my_class'.modulize    )
    assert_equal( '::MyModule::MyClass', '/my_module/my_class'.modulize   )
  end

  def test_methodize
    assert_equal( 'hello_world', 'HelloWorld'.methodize )
    assert_equal( '__unix_path', '/unix_path'.methodize )
  end

  def test_pathize
    assert_equal( 'my_module/my_class',   'MyModule::MyClass'.pathize )
    assert_equal( 'uri',                  'URI'.pathize )  # Hmm... this is reversible?
    assert_equal( '/my_class',            '::MyClass'.pathize )
    assert_equal( '/my_module/my_class/', '/my_module/my_class/'.pathize )
  end

  def test_dresner
    # assert_still_legible ;-)
    assert_nothing_raised { "How are you today?".dresner }
  end

  def test_dresner
    # assert_still_legible ;-)
    assert_nothing_raised { "How are you today?".dresner! }
  end

end


class Test_Style_NameCase < Test::Unit::TestCase
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

