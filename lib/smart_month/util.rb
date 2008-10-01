module SmartMonth
  # Responsible for odds and ends.
  module Util
    # returns the month as a string.
    def inspect
     "#{self.to_s}"
    end
    
    # returns the year of the current month.
    def year
      @date.year
    end
    
    # returns the month and the year as a string.
    def inspect!
      "#{self.to_s} #{@date.year}"
    end

    # returns the month as a string.
    def to_s
       Month::NAMES[@date.month]
    end

    # returns the month as a fixnum.
    def to_i
      Month::NAMES.index(self.to_s)
    end
    # add support for int as well.
    alias :to_int :to_i
  end
end