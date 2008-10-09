require 'english/obfuscate'
require 'test/unit'

#$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
#$:.unshift File.join(File.dirname(__FILE__), "..", "test")

class Test_Obfuscate < Test::Unit::TestCase

  def test_dresner
    # assert_still_legible ;-)
    assert_nothing_raised { "How are you today?".dresner }
  end

  def test_dresner
    # assert_still_legible ;-)
    assert_nothing_raised { "How are you today?".dresner! }
  end

end

