require 'test_helper'

class CalculationsTest < Test::Unit::TestCase

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
     assert_equal Month.december(2008).last, Date.new(2008,12,31)
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
     assertion = Month.august(2006).every!(:monday,:wednesday)
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
   def test_should_return_every_day_of_month_as_array
     assertion = Month.april(2003).every(:tuesday)
     assert_equal assertion.size, 5
     assert_equal assertion, [Date.new(2003,4,1),Date.new(2003,4,8),Date.new(2003,4,15),Date.new(2003,4,22),Date.new(2003,4,29)]
   end

   # Tested By: Derek Perez
   def test_should_retun_every_set_of_days_of_month_as_array
     assertion = Month.august(2006).every(:monday,:wednesday)
     # verify
     assert assertion.is_a?(Array)
     # check for data integrity
     assert_equal assertion.size, 9
     assert_equal assertion, [Date.new(2006,8,2),Date.new(2006,8,9),Date.new(2006,8,16),Date.new(2006,8,23),Date.new(2006,8,30),Date.new(2006,8,7),Date.new(2006,8,14),Date.new(2006,8,21),Date.new(2006,8,28)]
   end

   # Tested By: Derek Perez
   def test_should_return_total_days_of_month
     assert_equal Month.april(2004).size, 30
     assert_equal Month.april(2004).length, 30 # alternate access
   end

end