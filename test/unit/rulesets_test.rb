require 'test_helper'

class RulesetsTest < Test::Unit::TestCase
  
  # load up the test yaml file
  def setup
    SmartMonth::Rulesets.load_file(File.dirname(__FILE__)+'/samples/test_ruleset.yml')
  end
  
  # tested By: Derek Perez
  def test_should_return_date_from_string
    # floating year example
    floating_year = {:year => Time.now.year, :month => 12, :day => 25}
    assert_equal floating_year, SmartMonth::Rulesets.new.send(:parse_string_as_date,{'when' => "December 25th"})
    # fixed year example
    floating_year = {:year => 2010, :month => 12, :day => 25}
    assert_equal floating_year, SmartMonth::Rulesets.new.send(:parse_string_as_date,{'when' => "December 25th, 2010"})
  end
  
end