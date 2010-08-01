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
    2.times { Factory(:address, :person => person) }
    person.addresses.count.should == 2
  end

  it "should list all the items they bought" do
    ['Curly', 'Shemp', 'Moe'].each do |person_name|
      p = Factory(:person, :first_name => person_name)
      o = Order.create :customer => p
      ['mop', 'top', 'cop'].each do |item_name|
        item = Factory(:item, :name => "#{person_name} #{item_name}")
        LineItem.create :item => item, :order => o
      end
    end
    p = Person.find_by_first_name 'Moe'
    p.all_purchases.collect { |i| i.name }.
          should == ['Moe mop', 'Moe top', 'Moe cop']
  end

  describe "loyal_customer namedscope" do
    #list customers that bought two or more items in the last 3 months
    before do
      @person1 = Factory(:person)
      @order1 = Factory(:order, :customer_id => @person1.id)
    end

    it "should find a person who bought two items two months ago" do
      2.times { Factory(:line_item, :created_at => Date.today - 2.months, :order_id=>@order1.id) }
      Person.loyal_customers.length.should == 1
      Person.loyal_customers.first.should be_kind_of(Person)
    end

    it "should not find a person who bought one item two months ago" do
      Factory(:line_item, :created_at => Date.today - 2.months)
      Person.loyal_customers.length.should == 0
    end

    it "should not find a person who bought two items 4 months ago" do
      2.times { Factory(:line_item, :created_at => Date.today - 4.months, :order_id=>@order1.id) }
      Person.loyal_customers.length.should == 0
    end

    it "should find a person who bought one item 3 months ago and 1 item one day ago" do
      order2 = Factory(:order, :customer_id => @person1.id)
      Factory(:line_item, :created_at => Date.today - 3.months, :order_id=>@order1.id)
      Factory(:line_item, :created_at => Date.today - 1.day, :order_id=>order2.id)
      Person.loyal_customers.length.should == 1
    end
  end

end
