require 'lib/month'

# inject smart_month into the Time class.
class ::Time
  def month
    return Month.new(self.mon,self.year)
  end
end

# this is used to make the time more console-readable.
class ::Date
  def inspect
    strftime("%a, %d %b %Y")
  end
end