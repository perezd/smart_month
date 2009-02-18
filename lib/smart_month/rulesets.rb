require 'yaml'

module SmartMonth
  class Rulesets
    def self.load(path)
      @@ruleset_yml = YAML::load(File.open(path))
    end
    
    def create_condition_with_date
    end
    
    def create_condition_with_frequency
      "([Month.new(#{month}).#{freq}!(#{days})].flatten.include? Date.new(self.year,self.month,self.day)) ? true : false"
    end
    
    def self.parse_date(rule)
      month,day,year = rule.split
      day.gsub!(',','')
      day.gsub!(/st|rd|th|nd/,'')
      {:year => year, :month => month, :day => day}
    end
  
  end
end