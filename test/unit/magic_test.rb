require 'test_helper'

class MagicTest < Test::Unit::TestCase
    
  # Tested By: Derek Perez
  def test_should_create_month_through_class_factory
    assert_equal Month.april, Month.new("April")
    assert_equal Month.march, Month.new(3)
    assert_equal Month.june(2010), Month.new("June",2010)
  end
  
  # Tested By: Derek Perez
  def test_should_magically_determine_function_execution
    assert_equal Month.march.first(:tuesday), Month.march.first_tuesday
    assert_equal Month.may.every_thursday, Month.may.every(:thursday)
    assert_equal Month.june.every_tuesday_and_friday, Month.june.every(:tuesday,:friday)
  end
  
  # Tested By: Derek Perez
  def test_should_return_month_as_array_index
    assert_equal Month[3], Month.march
  end
  
  # Tested By: Derek Perez
  def test_should_return_month_as_hash_key
    assert_equal Month[:june], Month.june
    assert_equal Month["april"], Month.april # alternate
  end
  
  # Tested By: Derek Perez
  def test_should_return_days_week_control
    assert_equal Month.march.first_and_third_tuesday, [Month.march.first(:tuesday), Month.march.third(:tuesday)]
    assert_equal Month.march.first_and_last_friday, [Month.march.first(:friday), Month.march.last(:friday)]
    assert_equal Month.march.first_and_second_last_friday, [Month.march.first(:friday), Month.march.second(:friday), Month.march.last(:friday)]
  end
  
end