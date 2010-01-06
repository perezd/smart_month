require 'date'
require File.expand_path(File.dirname(__FILE__)) + '/month'
require File.expand_path(File.dirname(__FILE__)) + '/smart_month/extensions/date'

# inject smart_month system into the Time class.
class ::Time
  def month
    return Month.new(self.mon,self.year)
  end
end

