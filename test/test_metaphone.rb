require 'english/metaphone'

require 'test/unit'
require 'yaml'

class TC_Metaphone < Test::Unit::TestCase

  DIR      = File.dirname(__FILE__)

  DATA     = YAML::load(File.read(File.join(DIR,'fixture/metaphone.txt')))
  DATA_ALT = YAML::load(File.read(File.join(DIR,'fixture/metaphone_lp.txt')))

  def test_cases
    DATA.each do |input, expected_output|
      assert_equal expected_output, English::Metaphone.metaphone(input)
    end
  end

  def test_cases_for_alternate_implementation
    DATA_ALT.each do |input, expected_output|
      assert_equal expected_output, English::Metaphone.metaphone(input, true)
    end
  end

  def test_junk
    assert_equal English::Metaphone.metaphone('foobar'),
      English::Metaphone.metaphone('%^@#$^f%^&o%^o@b#a@#r%^^&')
    assert_equal English::Metaphone.metaphone('foobar', true),
      English::Metaphone.metaphone('%^@#$^f%^&o%^o@b#a@#r%^^&', true)
  end

  def test_caps
    assert_equal English::Metaphone.metaphone('foobar'),
      English::Metaphone.metaphone('FOOBAR')
    assert_equal English::Metaphone.metaphone('foobar', true),
      English::Metaphone.metaphone('FOOBAR', true)
  end

  def test_string
    assert_equal 'F BR BS', English::Metaphone.metaphone('foo bar baz')
    assert_equal 'N WT', English::Metaphone.metaphone('gnu what')
    assert_equal 'F BR BS', English::Metaphone.metaphone('foo bar baz', true)
    assert_equal 'N WT', English::Metaphone.metaphone('gnu what', true)
  end

end


class TC_DoubleMetaphone < Test::Unit::TestCase

  DIR  = File.dirname(__FILE__)
  DATA = File.read(File.join(DIR,'fixture/double_metaphone.txt')).split(/\n/)

  DATA.each_with_index do |line, i|
    row = *line.split(', ')
    #primary, secondary = English::Metaphone[row[0]]
    primary, secondary = English::Metaphone.double_metaphone(row[0])

    define_method("test_#{i}") do
      assert_equal row[1], primary
      assert_equal row[2], (secondary.nil?? primary : secondary)
    end
  end

end

