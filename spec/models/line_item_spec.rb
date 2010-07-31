require 'spec_helper'

describe LineItem do
  before(:each) do
    @valid_attributes = Factory.attributes_for(:line_item)
  end

  it "creates a new instance given valid attributes" do
    LineItem.new(@valid_attributes).should be_valid
  end

  it "belongs_to a order" do
    Factory(:line_item).should respond_to(:order)
  end

  it "belongs_to an item" do
    Factory(:line_item).should respond_to(:item)
  end

end
