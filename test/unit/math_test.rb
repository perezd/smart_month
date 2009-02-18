require 'test_helper'

class MathTest < Test::Unit::TestCase
    
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
  
end