require 'yaml'

module SmartMonth
  class Rulesets
    
    def self.load_file(path)
      @@ruleset_yml = YAML::load(File.open(path))
      self.new.activate_rules!
    end
        
    def activate_rules!
      @@ruleset_yml.each_key do |rule|
        inject_rule(rule, @@ruleset_yml[rule])
      end
    end
    
    protected 
    
    def parse_string_as_date(rule)
      # first attempt to parse the string and load structure
      month,day,year = rule['when'].split
      year = Time.now.year.to_i if year.nil?
      data = {:year => year.to_i, :month => Month.new(month).to_i, :day => day.to_i}
      return data
    end

    def inject_rule(name,rule)
      meth_name = name.gsub(' ','_').downcase
      data = parse_string_as_date(rule)
      # don't define the rulset methods if they might override existing methods!
      unless Month.respond_to?(meth_name) && Date.respond_to?(meth_name)
        # define root definition for lookup
        Month.send(:define_method,meth_name) {
          (self.month == data[:month]) ? Date.new(data[:year],data[:month],data[:day]) : nil
        }
        # alias root definition as boolean
        Date.send(:define_method, "is_#{meth_name}?") {
          self == Month[data[:month]].send(meth_name)
        }
      end
    end
    
  end
end