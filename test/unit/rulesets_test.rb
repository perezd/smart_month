require 'test_helper'

class RulesetsTest < Test::Unit::TestCase
  
  # load up the test ruleset yaml file
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
  
  # tested by: Derek Perez
  def test_should_insert_rule_manually    
    SmartMonth::Rulesets.add_rule('My Manual Rule', 'March 25th 2009')
    assert_equal Month[3].my_manual_rule, Date.new(2009,3,25)
  end
  
  # tested by: Derek Perez
  def test_should_override_rule_definition_manually
    initial = Month.december.christmas
    SmartMonth::Rulesets.add_rule('Christmas', 'December 12th, 2009')
    assert initial != Month.december.christmas
    assert_equal Month.december.christmas, Date.new(2009,12,12)
  end
  
  # tested by: Derek Perez
  def test_should_return_frequency_from_string
    # parsed values
    expected_every =  [:freq, 'every_friday_and_saturday',nil,0]
    expected_first_second = [:freq,'first_and_second_wednesday',nil,0]
    expected_monday = [:freq, 'first_monday',nil,0]
    # test
    assert_equal expected_every, SmartMonth::Rulesets.new.send(:parse_string_as_frequency,{'when' => "every friday and saturday"})
    assert_equal expected_first_second, SmartMonth::Rulesets.new.send(:parse_string_as_frequency,{'when' => "first and second wednesday"})
    assert_equal expected_monday, SmartMonth::Rulesets.new.send(:parse_string_as_frequency,{'when' => "first monday"})    
  end
  
  # tested by: Derek Perez
  def test_should_return_context_of_months
    # parsed values
    expected_march = [:freq, 'every_monday',['march'], 0]
    expected_march_june = [:freq, 'first_tuesday',['march','june'],0]
    expected_march_june_april = [:freq, 'second_tuesday',['march','june','april'],0]
    # test
    assert_equal expected_march, SmartMonth::Rulesets.new.send(:parse_string_as_frequency,{'when' => "every monday in march"})
    assert_equal expected_march_june, SmartMonth::Rulesets.new.send(:parse_string_as_frequency,{'when' => "first tuesday in march and june"})
    assert_equal expected_march_june_april, SmartMonth::Rulesets.new.send(:parse_string_as_frequency,{'when' => "second tuesday in march, june, and april"})
  end

  # tested by: Derek Perez
  def test_should_return_context_of_month_with_year
    expected_2010 = [:freq, 'every_monday',['november'],2010]
    assert_equal expected_2010, SmartMonth::Rulesets.new.send(:parse_string_as_frequency,{'when' => 'every monday in november', 'year' => '2010'})
  end
  
  # tested by: Derek Perez
  def test_should_parse_rules
    # parsed values
    rule_with_date = [:date, {:year => 2009, :day => 5, :month => 12}]
    rule_with_freq = [:freq, "every_monday", ["march"], 0]
    rule_with_freq_and_year = [:freq, "first_and_second_tuesday",["april"],2009]
    # test
    assert_equal rule_with_date, SmartMonth::Rulesets.new.send(:parse,{'when'=>'December 5th, 2009'})
    assert_equal rule_with_freq, SmartMonth::Rulesets.new.send(:parse,{'when'=>'every monday in march'})
    assert_equal rule_with_freq_and_year, SmartMonth::Rulesets.new.send(:parse,{'when'=>'first and second tuesday in april','year'=>'2009'})
  end
  
  
  def test_should_not_apply_alias_if_root_undefined
  end
  
  # tested by: Derek Perez
  def test_should_not_remove_undefined_rule
    assert !SmartMonth::Rulesets.remove_rule("Rule fake")
  end
  
  # tested by: Derek Perez
  def test_should_remove_defined_rule
    assert SmartMonth::Rulesets.remove_rule("Christmas")
    assert !Month.december.respond_to?(:christmas)
    assert !Month.december.first.respond_to?(:is_christmas?)
  end
  
end