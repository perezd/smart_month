require 'yaml'

module SmartMonth
  class Rulesets
    
    def self.load_file(path)
      @@ruleset_yml = YAML::load(File.open(path))
    end
    
    def self.parse_string_as_date(rule)
      # first attempt to parse the string and load structure
      month,day,year = rule['when'].split
      data = {:year => year, :month => month, :day => day}
      
      # allow overrides if defined
      ['year','month','day'].each do |item|
        data[item] = rule[item] unless rule[item].nil?
      end
      
      # sanitize 
      data[:day].gsub!(',','')
      data[:day].gsub!(/st|rd|th|nd/,'')
      data[:month].downcase!
      
      # return the data structure
      return data
    end

  end
end