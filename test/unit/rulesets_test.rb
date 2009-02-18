require 'test_helper'

class RulesetsTest < Test::Unit::TestCase
  
  # load up the test yaml file
  def setup
    SmartMonth::Rulesets.load_file(File.dirname(__FILE__)+'/samples/test_ruleset.yml')
  end
  
  # tested By: Derek Perez
  def test_should_return_date_from_string
    expected = {:year => nil, :month => "december", :day => "25"}
    assert_equal expected, SmartMonth::Rulesets.send(:parse_string_as_date,{'when' => "December 25th"})
  end
  
  def test_should_return_frequency_from_string
  end
  
end