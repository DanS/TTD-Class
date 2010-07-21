require 'spec_helper'

describe Address do
  before(:each) do
    @valid_attributes = {
            :street => "123 High Street",
            :city   => "Palo Alto",
            :zip    => "99876"
    }
  end

  it "should create a new instance given valid attributes" do
    Address.create!(@valid_attributes)
  end

  [:street, :city, :zip].each do |att|
    it "should have error message if #{att} is nil" do
      a = Address.create(@valid_attributes[att] = nil)
      a.errors.on(att).should =~ /can't be blank/
    end

  end
end
