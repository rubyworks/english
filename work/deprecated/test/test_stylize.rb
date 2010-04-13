require 'english/stylize'
require 'test/unit'

#$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
#$:.unshift File.join(File.dirname(__FILE__), "..", "test")

class Test_Stylize < Test::Unit::TestCase

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

end

