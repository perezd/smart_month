module SmartMonth
  # Responsible for all core month/week calculations.
  module Calculations  
    # returns the first date of the day requested. 
    # if no day is defined, it returns the very first day of the month.
    def first(day = nil)
     (day.nil?) ? @date : nth_weekday(day,1)
    end

    # returns the second date of the day requested.
    def second(day)
      nth_weekday(day,2)
    end

    # returns the third date of the day requested.
    def third(day)
      nth_weekday(day,3)
    end
    
    # returns the fourth (or potentially last), date of the day requested.
    def fourth(day)
      nth_weekday(day,4) || self.last(day)
    end

    # returns last date of the day requested.
    # if no day is defined, it returns the very last day of the month.
    def last(day = nil)
     (day.nil?) ? Date.new(@date.year,@date.month,-1) : every(day).last
    end

    # returns an array of dates of the day requested.
    # if an array of dates are passed in, a hash of day names containing
    # the corresponding date are returned.
    def every!(*days)
     days = [days].flatten
     if days.size == 1
       dates = []
       (1..5).each do |week|
          dates << nth_weekday(days.first,week)
       end
       dates.compact!
     else
       dates = {}
       days.each do |day|
         day = day.to_sym
         dates[day] = []
         (1..5).each do |week|
            dates[day] << nth_weekday(day,week)
         end
         dates[day].compact!
       end
     end
     dates
    end
    
    # this returns the same data as #every! but removes the hash
    # organization of the data.
    def every(*days)
      days = every!(days)
      (days.is_a?(Array)) ? days : days.values.flatten
    end
    
    # returns the total number of days in month.
    def size
      self.last.day.to_i
    end
    alias_method :length, :size
    
    private

    # this is the heart of the calculations module.
    def nth_weekday(day,limit = 0)
      raise RuntimeError, "#{day} is not a valid day of the week" unless Month::DAYS.collect{|d| d.downcase}.include?(day.to_s)
      limit -= 1 # make more sense to humans
      requested_weekday = Month::DAYS.collect{|d| d.downcase}.index(day.to_s)
      iter_date = Date.new(@date.year,@date.month,1)
      # find the first day that works
      until iter_date.wday == requested_weekday
        iter_date +=1
      end
      # then add a multipler based on the limit
      iter_date = iter_date + (limit*7)
      # if the date we've iterated to doesn't exist in this month, send out a nil.
      return iter_date unless iter_date.month != @date.month
    end  
  end
end