require 'spec_helper'

describe Person do

  before do
    @valid_attributes = {
          :first_name => "Joe",
          :last_name => "Blow"
    }

    @person = Person.create(@valid_attributes)
    @valid_att_addresses = Factory.attributes_for(:address)
  end

  it "should save correctly given valid attributes" do
    lambda {
      Person.create!(@valid_attributes)
    }.should change(Person, :count).by(1)
  end

  [:first_name, :last_name].each do |attrib|
    it "should not be valid without #{attrib}" do
      @valid_attributes[attrib] = nil
      Person.create(@valid_attributes).should_not be_valid
    end
  end

  it "should accept a middle name" do
    @valid_attributes[:middle_name] = 'Jessus'
    lambda {
      Person.create!(@valid_attributes)
    }.should change(Person, :count).by(1)
  end

  describe "full name method" do

    it "should return first_name single space last_name if no middle_name" do
      p = Person.create(@valid_attributes)
      p.full_name.should == 'Joe Blow'
    end

    it "should include middle name if given" do
      p = Person.new(@valid_attributes.merge({:middle_name => 'Jessus'}))
      p.full_name.should == "Joe Jessus Blow"
    end

  end

  it "can have many Addresses" do
    person = Factory(:person)
    2.times {Factory(:address, :person => person)}
    person.addresses.count.should == 2
  end

end
