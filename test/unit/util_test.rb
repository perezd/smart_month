require 'test_helper'

class UtilTest < Test::Unit::TestCase
  
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