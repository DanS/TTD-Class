require 'spec_helper'

describe Item do
  before(:each) do
    @valid_attributes = Factory.attributes_for(:item)
  end

  it "should create a new instance given valid attributes" do
    Item.new(@valid_attributes).should be_valid
  end

  [:name, :price].each do |req_attr|
    it "should not be valid without presence of #{req_attr}" do
      i = Item.new
      i.should_not be_valid
      i.errors_on(req_attr).should_not be_nil
    end
  end

  it "has many line_items" do
    Factory(:item).should respond_to(:line_items)
  end

  it "returns all items ordered by popularity" do
    people = (1..10).to_a.collect { Factory(:person) }
    items = (1..10).to_a.collect { |i| Factory(:item, :name => "item#{i}") }
    [6, 10, 1, 7, 3, 8, 5, 9, 4, 2].each do |count|
      count.times do
        order = Factory(:order, :customer => people[count - 1])
        Factory(:line_item, :order_id => order.id, :item_id => items[count - 1].id)
      end
    end
    result = Item.by_popularity
    result.collect { |i| i['name'] }.should == ["item10", "item9", "item8", "item7", "item6", "item5", "item4", "item3", "item2", "item1"]
    result.first.should be_kind_of(Item)
  end

end
