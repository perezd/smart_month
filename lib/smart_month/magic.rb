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
      
      # execute lookup using week as positioning control
      if week_position?(raw[0]) && raw[1] == "and"
        results = []
        # parse the request
        arg = raw.slice!(raw.index(raw.last))
        funcs = parse_arguments(raw)
        # execute
        funcs.each do |func|
          results << self.send(func,arg) if week_position?(func)
        end
        return results
        
      # execute an every pattern on n-days
      elsif raw[0] == "every"
        # parse the request
        func = raw.slice!(0)
        args = parse_arguments(raw)
        # execute
        return self.every(args)
        
      # revert to basic singular lookup or raise an exception
      elsif self.respond_to?(raw[0]) 
        func = raw.slice!(0)
        return self.send(func,raw) if week_position?(func)
      else
        raise NoMethodError
      end
    end
  
    private 
    
    # a quicky helper for breaking up text to args.
    def parse_arguments(args)
      args.select { |a| a != 'and' }
    end
    
    # this is used a lot for validity and sanitizing.
    def week_position?(compare)
      [compare].flatten.each do |comp|
        %w(first second third fourth last).include?(comp)
      end
    end
    
  end
end