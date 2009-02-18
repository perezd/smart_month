$LOAD_PATH << File.dirname(__FILE__) + '/smart_month'

require 'calculations'
require 'collection'
require 'math'
require 'magic'
require 'util'
require 'rulesets'

class Month
  # gather the modules
  include SmartMonth::Calculations
  include SmartMonth::Collection
  include SmartMonth::Math
  include SmartMonth::Util
  include SmartMonth::Magic
  # abstraction that returns an array of months.
  NAMES = Date::MONTHNAMES
  # abstraction that returns an array of day names.
  DAYS = Date::DAYNAMES  
  # constructor, takes 2 optional arguments, if you don't provide them, it will default to
  # the current month and year.
  def initialize(month = Time.now.mon, year = Time.now.year)
    @date = Date.new(year,( month.is_a?(Integer) ? month : Month::NAMES.index(month.to_s.capitalize) ) ,1) 
  end
end