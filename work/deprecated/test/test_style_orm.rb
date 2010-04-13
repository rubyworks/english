require 'english/style_orm'
require 'test/unit'

#$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
#$:.unshift File.join(File.dirname(__FILE__), "..", "test")

class Test_StyleORM < Test::Unit::TestCase

  def test_demodulize_01
    a =  "Down::Bottom"
    assert_equal( "Bottom", a.demodulize )
  end

  def test_demodulize_02
    b =  "Further::Down::Bottom"
    assert_equal( "Bottom", b.demodulize )
  end

  def test_demodulize_03
    assert_equal( "Unit", "Test::Unit".demodulize )
  end

  def test_camelize
    assert_equal( 'ThisIsIt', 'this_is_it'.camelize )
  end

  def test_humanize
    assert_equal( 'This is it', 'this_is_it'.humanize )
  end

  def test_demodulize_01
    a =  "Down::Bottom"
    assert_equal( "Bottom", a.demodulize )
  end

  def test_demodulize_02
    b =  "Further::Down::Bottom"
    assert_equal( "Bottom", b.demodulize )
  end

  def test_demodulize_03
    assert_equal( "Unit", "Test::Unit".demodulize )
  end

  def test_modulize
    assert_equal( 'MyModule::MyClass',   'my_module__my_class'.modulize   )
    assert_equal( '::MyModule::MyClass', '__my_module__my_class'.modulize )
    assert_equal( 'MyModule::MyClass',   'my_module/my_class'.modulize    )
    assert_equal( '::MyModule::MyClass', '/my_module/my_class'.modulize   )
  end

  #def test_methodize
  #  assert_equal( 'hello_world', 'HelloWorld'.methodize )
  #  assert_equal( '__unix_path', '/unix_path'.methodize )
  #end

  #def test_pathize
  #  assert_equal( 'my_module/my_class',   'MyModule::MyClass'.pathize )
  #  assert_equal( 'uri',                  'URI'.pathize )  # Hmm... this is reversible?
  #  assert_equal( '/my_class',            '::MyClass'.pathize )
  #  assert_equal( '/my_module/my_class/', '/my_module/my_class/'.pathize )
  #end

  #def test_dresner
  #  # assert_still_legible ;-)
  #  assert_nothing_raised { "How are you today?".dresner }
  #end

  #def test_dresner
  #  # assert_still_legible ;-)
  #  assert_nothing_raised { "How are you today?".dresner! }
  #end

end

