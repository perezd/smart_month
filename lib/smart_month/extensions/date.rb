# This module extends the core Date class functionality
# for use throughout smart_month.
module SmartMonth
  module Extensions
    module Date
      
      # this is to make date objects more console-friendly
      def inspect
        strftime("%a, %d %b %Y")
      end

      # allows a date to retrun the current day its set to as an integer
      def to_i
        self.day.to_i
      end
      
      # allows a date to return the day of the week it currently is as a string
      def to_day
        Month::DAYS[self.wday]
      end
      
    end
  end
end


# inject the extension mixin to the base class
class ::Date
  include SmartMonth::Extensions::Date
end