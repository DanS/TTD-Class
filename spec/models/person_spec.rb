require 'spec_helper'

describe Person do

  before do
    @valid_attributes = {
          :first_name => "Joe",
          :last_name => "Blow"
    }
  end

  it "should save correctly given valid attributes" do
    lambda {
      Person.create!(@valid_attributes)
    }.should change(Person, :count).by(1)
  end

  [:first_name, :last_name].each do |attrib|
    it "should not be valid without #{attrib}" do
      @valid_attributes[attrib] = nil
      p = Person.create(@valid_attributes)
      p.should_not be_valid
    end
  end

  it "should a full_name method" do
    p = Person.create(@valid_attributes)
    p.full_name.should == 'Joe Blow'
  end

  it "should accept a middle name" do
    @valid_attributes[:middle_name] = 'Jessus'
    lambda {
      Person.create!(@valid_attributes)
    }.should change(Person, :count).by(1)
  end

  it "can have many Addresses" do
    p = Person.create(@valid_attributes)
    add1 = Address.create(:person_id => p)
    add2 = Address.create(:person_id => p)
    p.addresses.count.should == 2
  end
  
end
