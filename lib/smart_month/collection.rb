module SmartMonth
  # Responsible for all collection-based functionality.
  module Collection
    # this is a helper class that is used primarily by Month#each.
    # should not be used standalone for any reason, really.
    class Day
      def initialize(date)
        @date = date
      end
      # returns the date numeric of the day (in regards to the month it resides in).
      def to_i
        @date.day
      end
      # returns the string value of the weekday.
      def to_s
        Month::DAYS[@date.wday]
      end
    end
    
    # allows for increment by copy
    def next
      if @date.month + 1 > 12
        Month.new(1,@date.year+1)
      else
        Month.new(@date.month+1,@date.year)
      end
    end

    # allows for in place incrementing by 1
    def next!
      if @date.month + 1 > 12
        @date = Date.new(@date.year+1,@date.month,1)
      else
        @date = Date.new(@date.year,@date.month+1,1)
      end
    end

    # allows for deincrement by copy
    def previous
      if @date.month - 1 == 0
        Month.new(12,@date.year-1)
      else
        Month.new(@date.month-1,@date.year)
      end
    end
    alias_method :prev, :previous

    # allows for in place deincrementing by 1
    def previous!
      if @date.month - 1 == 0
        @date = Date.new(@date.year-1,12,1)
      else
        @date = Date.new(@date.year,@date.month-1,1)
      end
    end
    alias_method :prev!, :previous!
    
    # allows us to iterate internally on the days of a given month.
    # It also uses the helpful Day class that provides some fun methods. (see SmartMonth::Collection::Day)
    def each(first = 1, last = self.last.day, &block)
     (1..self.last.day).each do |e|
       block.call(Day.new(Date.new(@date.year,@date.month,e)))
     end
     return self
    end
  end
end