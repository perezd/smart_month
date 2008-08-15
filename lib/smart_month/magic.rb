module SmartMonth
  # Magic is responsible for the rails-like dynamic "magic finders".
  module Magic
    
    # extends the Month class with the Month factory
    def self.included(base)
      base.extend MonthFactory
    end
    
    # This module allows your code to ignore the class instantiation, simply do Month.june!
    module MonthFactory
      # singleton month factory
      def method_missing(meth,*args)
        return new(meth.to_s.capitalize, (args.first || Time.now.year)) if Month::NAMES.include? meth.to_s.capitalize
      end
      
      # this allows you to essentially treat the month as a hash or array object to construct new months.
      def [](month)
         new(month)
      end
    end
    
    # nice catchall to allow rails-esque APIs if you choose to.
    def method_missing(meth)
      raw = meth.to_s.split("_")
      func = raw.slice!(0)
      if func == "every"
        args = raw.select { |a| a != "and" }
        self.send(func,args)
      else
        self.send(func,raw) if %w(first second third last).include? func
      end
    end
  end
end