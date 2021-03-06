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

  it "adds a person along with an address for that person" do
    params = {:person => {
          :first_name =>"Kai",
          :last_name => "Middleton",
          :addresses_attributes => [
                {:street => '123 Easy St',
                 :city => "Albany",
                 :state => "CA",
                 :zip => '12345'},
                {:street => '123 Hard st.',
                 :city => "San Francisco",
                 :state =>"CA",
                 :zip => '98765'}]
    }
    }
    p = Person.create(params[:person])
    p.addresses.count.should == 2
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

    it "should find a person who bought two of the same item, on the same order, today" do
      item = Factory(:item)
      person = Factory(:person)
      order = Factory(:order, :customer_id => person.id)
      2.times { Factory(:line_item, :item_id => item.id, :order_id => order.id) }
    end

    it "should find a person who bought one item 3 months ago and a different item one day ago" do
      order2 = Factory(:order, :customer_id => @person1.id)
      Factory(:line_item, :created_at => Date.today - 3.months, :order_id=>@order1.id)
      Factory(:line_item, :created_at => Date.today - 1.day, :order_id=>order2.id)
      Person.loyal_customers.length.should == 1
    end
  end

  describe "with_addresses method" do
    before do
      @person = Factory(:person, :first_name=>'Franklin', :middle_name=>'Dwight', :last_name=>'Rosevelt')
      Factory(:address, :person => @person, :state=>'CA')
    end

    it "should return all person attributes as well as all address attributes" do
      @person.with_addresses[:first_name].should == 'Franklin'
      @person.with_addresses[:addresses].first[:state].should == 'CA'
    end

    it "should return multiple addresses if present" do
      Factory(:address, :person => @person, :state=>'MI')
      @person.with_addresses[:addresses].map {|a| a[:state]}.sort.should == ['CA', 'MI']
    end

    it "does not have unwanted keys for person or addresses" do
      [:id, :created_at, :updated_at].each do |unwanted|
        @person.with_addresses.keys.should_not include unwanted
        @person.with_addresses[:addresses].first.keys.should_not include(unwanted)
      end
    end
  end

end
