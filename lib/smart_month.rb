require 'date'
require 'month'
require 'extensions/date'

# inject smart_month system into the Time class.
class ::Time
  def month
    return Month.new(self.mon,self.year)
  end
end
