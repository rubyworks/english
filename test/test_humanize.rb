require 'english/humanize'
require 'test/unit'

#$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
#$:.unshift File.join(File.dirname(__FILE__), "..", "test")

class Test_Humanize < Test::Unit::TestCase

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

end

