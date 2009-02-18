require 'yaml'

module SmartMonth
  class Rulesets
    
    def self.load(path)
      @@ruleset_yml = YAML::load(File.open(path))
    end
    
    def self.parse_string_as_date(rule)
      month,day,year = rule.split
      day.gsub!(',','')
      day.gsub!(/st|rd|th|nd/,'')
      {:year => year, :month => month, :day => day}
    end
  
  end
end