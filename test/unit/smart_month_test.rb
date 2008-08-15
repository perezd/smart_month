require "test/unit"
require File.dirname(__FILE__) + '/../test_helper'
require "date"

class SmartMonthTest < Test::Unit::TestCase
  
  # SmartMonth::Calcuations
  
  # Tested By: Derek Perez
  def test_should_return_first_day_of_month
    # test an ambiguous first, no weekday defined.
    assert_equal Month.april(2008).first, Date.new(2008,4,1)
    # test a specific first weekday.
    assert_equal Month.march(2002).first(:tuesday), Date.new(2002,3,5)
  end
  
  # Tested By: Derek Perez
  def test_should_return_second_day_of_month
    assert_equal Month.june(2007).second(:friday), Date.new(2007,6,8)
  end
  
  # Tested By: Derek Perez
  def test_should_return_third_day_of_month
    assert_equal Month.august(2008).third(:wednesday), Date.new(2008,8,20)
  end
  
  # Tested By: Derek Perez
  def test_should_return_last_day_of_month
    # test an ambiguous last, no weekday defined.
    assert_equal Month.december.last, Date.new(2008,12,31)
    # test a specific last weekday.
    assert_equal Month.september(2004).last(:friday), Date.new(2004,9,24)
    # test a specific ambiguous, fourth, no weekday defined.
    assert_equal Month.june(2004).fourth(:friday), Date.new(2004,6,25)
  end
  
  # Tested By: Derek Perez
  def test_should_return_fourth_and_last_day_of_month
    assert_equal Month.june(2004).fourth(:friday), Month.june(2004).last(:friday)
  end
  
  # Tested By: Derek Perez
  def test_should_return_every_day_of_month
    assertion = Month.april(2003).every(:tuesday)
    assert_equal assertion.size, 5
    assert_equal assertion, [Date.new(2003,4,1),Date.new(2003,4,8),Date.new(2003,4,15),Date.new(2003,4,22),Date.new(2003,4,29)]
  end
  
  # Tested By: Derek Perez
  def test_should_retun_every_set_of_days_of_month
    assertion = Month.august(2006).every(:monday,:wednesday)
    # verify
    assert assertion.is_a?(Hash)
    # monday assertions
    assert_equal assertion[:monday].size, 4
    assert_equal assertion[:monday], [Date.new(2006,8,7),Date.new(2006,8,14),Date.new(2006,8,21),Date.new(2006,8,28)]
    # wednesday assertions
    assert_equal assertion[:wednesday].size, 5
    assert_equal assertion[:wednesday],
     [Date.new(2006,8,2),Date.new(2006,8,9),Date.new(2006,8,16),Date.new(2006,8,23),Date.new(2006,8,30)]
    
  end
  
  # Tested By: Derek Perez
  def test_should_return_total_days_of_month
    assert_equal Month.april(2004).size, 30
    assert_equal Month.april(2004).length, 30 # alternate access
  end
  
  # SmartMonth::Collection
  
  # Tested By: Derek Perez
  def test_should_return_next_month
    # default by copy
    assert_equal Month.april.next, Month.may
    # alternate approach
    month = Month.april
    month.next!
    assert month, Month.may
  end
  
  # Tested By: Derek Perez
  def test_should_return_previous_month
    # default by copy
    assert_equal Month.may.previous, Month.april
    # alternate approach (by copy)
    assert_equal Month.june.prev, Month.may
    # alternate approach (by ref)
    month = Month.august
    month.previous!
    assert_equal month, Month.july
    # alternate approach (by copy)
    month = Month.july
    month.prev!
    assert_equal month, Month.june
  end
  
  # Tested By: Derek Perez
  def test_should_iterate_through_each_day_of_month
    counter = 0
    Month.april(2009).each do |day|
      counter += 1
      assert Month::DAYS.include?(day.to_s)
      assert (1..31).include?(day.to_i)
    end
    assert_equal counter, Month.april.size
  end
  
  # SmartMonth::Magic
  
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
  
  # SmartMonth::Math
  
  # Tested By: Derek Perez
  def test_should_add_month_and_fixnum
    assert_equal (Month.march + 2), 5
  end
  
  # Tested By: Derek Perez
  def text_should_subtract_month_and_fixnum
    assert_equal (Month.june - 4), 2
  end
  
  # Tested By: Derek Perez
  def test_should_divide_month_and_fixnum
    assert_equal (Month.december / 2), 6
  end
  
  # Tested By: Derek Perez
  def test_should_exponent_month_and_fixnum
    assert_equal (Month.may ** 2), 25
  end
  
  # Tested By: Derek Perez
  def test_should_modulo_month_and_fixnum
    assert_equal (Month.june % 7), 6
  end
  
  #SmartMonth::Util
  
  def test_should_return_year_of_month
    assert_equal Month.march(2004).year, 2004 
  end
  
  # Tested By: Derek Perez
  def test_should_inspect_month_as_string
    assert_equal Month.march.inspect, "March"
  end
  
  # Tested By: Derek Perez
  def test_should_inspect_month_and_year_as_string
    assert_equal Month.july(2012).inspect!, "July 2012"
  end
  
  # Tested By: Derek Perez
  def test_should_convert_month_to_string
    assert_equal Month.march.to_s, "March"
  end
  
  # Tested By: Derek Perez
  def test_should_convert_month_to_fixnum
    assert_equal Month.june.to_i, 6
  end
  
end
