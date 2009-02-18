require 'date' 
require File.dirname(__FILE__) + '/../../spec_helper'

describe "Date#<<" do

  it "should substract a number of months from a date" do
    d = Date.civil(2007,2,27) << 10
    d.should == Date.civil(2006, 4, 27)
  end

  it "should result in the last day of a month if the day doesn't exist" do
    d = Date.civil(2008,3,31) << 1
    d.should == Date.civil(2008, 2, 29)
  end

  it "should raise an error on non numeric parameters" do
    lambda { Date.civil(2007,2,27) << :hello }.should raise_error(NoMethodError)
    lambda { Date.civil(2007,2,27) << "hello" }.should raise_error(NoMethodError)
    lambda { Date.civil(2007,2,27) << Date.new }.should raise_error(NoMethodError)
    lambda { Date.civil(2007,2,27) << Object.new }.should raise_error(NoMethodError)
  end
  
end