require 'yaml'

module SmartMonth
  class Rulesets
    
    def self.load_yaml(yaml)
      @@rulesets = YAML::load(yaml)
      self.new.send(:activate_rules!)
    end
    
    def self.load_file(path)
      self.load_yaml(File.open(path))
    end
    
    def self.add_rule(name, rule)
      if rule.is_a?(String)
        @@rulesets.merge!( { name => {'when' => rule } } ) 
        self.new.send(:activate_rules!)
      end
    end
  
    protected 
    
    # iterates through all the rules currently defined in the class and injects them
    # if they are not currently implemented.
    def activate_rules!
      @@rulesets.each_key do |rule|
        inject_rule(rule, @@rulesets[rule]) unless Month.respond_to?(rule)
      end
    end
    
    # this method parses and defines the methods in our pre-existing ruby classes
    def inject_rule(name,rule)
      meth_name = name.gsub(' ','_').downcase
      type, data = parse_string_as_date(rule) # ||= parse_string_as_frequency(rule)
      # don't define the rulset methods if they might override existing methods!
      define_methods(type,meth_name,data) unless Month.respond_to?(meth_name) && Date.respond_to?(meth_name)
    end
    
    # this is the parsing process for basic "date as string" rules
    # (eg: 'December 12th, 2005' or 'March 15th')
    def parse_string_as_date(rule)
      # first attempt to parse the string and load structure
      month,day,year = rule['when'].split
      year = Time.now.year.to_i if year.nil?
      data = {:year => year.to_i, :month => Month.new(month).to_i, :day => day.to_i}
      return [:date,data]
    end
    
    def parse_string_as_frequency(rule)
      raise "not defined!"
      # return [:freq, data]
    end    
    
    private
    
    # do not define the alias unless the root is defined properly
    def define_methods(type,meth_name,data)
      define_alias(meth_name,data) if define_root(type,meth_name,data)
    end
    
    # define root definition for lookup directly into the Month class
    def define_root(type,meth_name,data)
      begin
        Month.send(:define_method,meth_name) {
          # algorithm template
          origin = "(self.month == #{data[:month]})"
          fail = 'nil'
          # determine lookup based on requested strategy
          case type
            when :date: qry = "Date.new(#{data[:year]},#{data[:month]},#{data[:day]})"
            when :freq: qry = 'true'
            else qry = 'nil'
          end
          # evaluate the custom rule into the function
          eval "#{origin} ? #{qry} : #{fail}"
        }
      rescue
        false
      end
      true
    end
    
    # alias root definition as boolean directly into the Date class
    def define_alias(meth_name,data)
      begin
        Date.send(:define_method, "is_#{meth_name}?") {
          [Month[data[:month]].send(meth_name)].flatten.include?(self)
        }
      rescue
        false
      end
      true
    end
  
  end
end