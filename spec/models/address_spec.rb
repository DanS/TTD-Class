require 'spec_helper'

describe Address do
  before(:each) do
    @valid_attributes = {
            :street => "123 High Street",
            :city   => "Palo Alto",
            :state  => "CA",
            :zip    => "99876"
    }
  end

  it "should create a new instance given valid attributes" do
    Address.create!(@valid_attributes).should be_valid
  end

  [:street, :city, :state, :zip].each do |att|
    it "should have error message if #{att} is nil" do
      a = Address.create(@valid_attributes[att] = nil)
      a.errors.on(att).should =~ /can't be blank/
    end
  end

  it "should default to USA for country if not given" do
    Address.create(@valid_attributes).country.should == 'USA'
  end

  it "should use passed value for country if given" do
    a = Address.new(@valid_attributes.merge({:country=>"Spain"}))
    a.country.should == 'Spain'
  end

end
