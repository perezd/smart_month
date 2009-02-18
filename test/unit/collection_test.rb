require 'test_helper'

class CollectionTest < Test::Unit::TestCase
    
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
      assert Month::DAYS.include?(day.to_day)
      assert (1..31).include?(day.to_i)
    end
    assert_equal counter, Month.april.size
  end
  
end