class ::Time
  def month
    return Month.new(self.mon,self.year)
  end
end