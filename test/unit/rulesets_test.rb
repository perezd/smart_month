require 'test_helper'

class RulesetsTest < Test::Unit::TestCase
  
  # load up the test yaml file
  def setup
    SmartMonth::Rulesets.load_file(File.dirname(__FILE__)+'/samples/test_ruleset.yml')
  end
  
  # tested by: Derek Perez
  def test_should_return_date_from_string_with_floating_year
    floating_year = {:year => Time.now.year, :month => 12, :day => 25}
    assert_equal [:date,floating_year], SmartMonth::Rulesets.new.send(:parse_string_as_date,{'when' => "December 25th"})
  end

  # tested by: Derek Perez
  def test_should_return_date_from_string_with_fixed_year
    fixed_year = {:year => 2010, :month => 12, :day => 25}
    assert_equal [:date,fixed_year], SmartMonth::Rulesets.new.send(:parse_string_as_date,{'when' => "December 25th, 2010"})
  end
  
  # tested By: Derek Perez
  def test_should_insert_rule_manually    
    SmartMonth::Rulesets.add_rule('My Manual Rule', 'March 25th 2009')
    assert_equal Month[3].my_manual_rule, Date.new(2009,3,25)
  end
  
  def test_should_override_rule_definition_manually
  end


  def test_should_return_frequency_from_string
  end
  
  def test_should_not_apply_previously_defined_rules
  end
  
  def test_should_not_apply_alias_if_root_undefined
  end
  
  
  
  
end