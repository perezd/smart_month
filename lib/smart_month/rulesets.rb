require 'yaml'

module SmartMonth
  class Rulesets
    
    ## LOADING RULES FROM YAML STREAM OR YAML FILE
    
    # this allows importing of rules into the system as
    # a raw yaml stream
    def self.load_yaml(yaml)
      @@rulesets = YAML::load(yaml)
      self.new.send(:activate_rules!)
    end
    
    # this allows import of rules into the system as
    # a yaml file on disk
    def self.load_file(path)
      File.open(path) { |yaml| self.load_yaml(yaml) }
    end
    
    ## MANUAL RULE MANAGEMENT
    
    # manually add a rule to the system. The rule argument should be a string,
    # an optional year argument can be passed if using a "natural frequency"
    def self.add_rule(name, rule, year = nil)
      @@rulesets = {} unless defined? @@rulesets
      if rule.is_a?(String)
        # define rule
        rule_hash = { name => {'when' => rule } }
        rule_hash[name]['year'] = year unless year.nil? 
        # merge and inject
        @@rulesets.merge!(rule_hash) 
        self.new.send(:inject_rule,name,@@rulesets[name])
      end
    end
    
    # updating and adding rules should do the same thing
    class << self
      alias_method :update_rule, :add_rule
    end
    
    # manually remove an existing rule from the system.
    def self.remove_rule(name)
      begin
        name = name.gsub(' ','_').downcase
        @@rulesets.delete_if { |k,v| k.downcase == name }
        Date.class_eval  { eval("undef is_#{name}?") }
        Month.class_eval { eval("undef #{name}")}
      rescue
       return false
      end
      return true
    end
  
    protected 
    
    # iterates through all the rules currently defined in the class and injects them
    # if they are not currently implemented.
    def activate_rules!
      @@rulesets.each_key do |rule|
        inject_rule(rule, @@rulesets[rule])
      end
    end
    
    # this method parses and defines the methods in our pre-existing ruby classes
    def inject_rule(name,rule)
      meth_name = name.gsub(' ','_').downcase
      type, data = parse(rule)
      # don't define the rulset methods if they might override existing methods!
      define_methods(type,meth_name,data) unless Month.respond_to?(meth_name) || Date.respond_to?(meth_name)
    end
    
    ## PARSER STRATEGIES
    
    # factory method for determing which parsing strategy to use based on the rule.
    def parse(rule)
      (Month::NAMES.include?(rule['when'].split[0].capitalize)) ? parse_string_as_date(rule) : parse_string_as_frequency(rule)
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
    
    # this is the parsing process for basic "date as frequency" rules
    # (eg: 'every tuesday and saturday' or 'every monday in march and april')
    def parse_string_as_frequency(rule)
      data,context = rule['when'].split('in')
      data = data.rstrip.gsub(' ','_').downcase unless data.nil?
      unless context.nil?
        context = context.gsub(/(\,|and)/,'').split
        context.collect {|ctx| ctx.downcase }
      end
      return [:freq, data, context, rule['year'].to_i]
    end    
    
    ## METHOD DEFINITION
    
    ## The folowing methods are used to alter the existing objects in memory
    # through the use of meta-programming. 
    
    private
    
    # do not define the alias unless the root is defined properly
    def define_methods(type,meth_name,data)
      define_alias(meth_name,data) if define_root(type,meth_name,data)
    end
    
    # define root definition for lookup directly into the Month class
    def define_root(type,meth_name,data)
      return false unless [:date,:freq].include?(type)
      begin
        # algorithm template
        context = "([#{data[:month]}].flatten.include?(self.month))"
        fail = 'nil'
        # determine lookup based on requested strategy
        case type
          when :date: qry = "Date.new(#{data[:year]},#{data[:month]},#{data[:day]})"
          when :freq: qry = 'true'
          else qry = 'nil'
        end
        # evaluate the custom rule into the function
        Month.send(:define_method,meth_name) {
          eval "#{context} ? #{qry} : #{fail}"
        }
      rescue
        return false
      end
      return true
    end
    
    # alias root definition as boolean directly into the Date class
    def define_alias(meth_name,data)
      begin
        Date.send(:define_method, "is_#{meth_name}?") {
          [Month[data[:month]].send(meth_name)].flatten.include?(self)
        }
      rescue
        return false
      end
      return true
    end
    
  end
end