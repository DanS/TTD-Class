require 'spec_helper'

describe Order do

  it "should create valid objects from the factory" do
    order = Factory(:line_item).order
    order.should be_valid
  end

  [:customer, :item].each do |attr|
    invalid_attributes = Factory.attributes_for(:order)[attr] = nil
    it "requires #{attr} to be valid" do
      o = Order.new invalid_attributes
      o.should_not be_valid
      o.errors_on(attr).should_not be_nil
    end
  end

  context "associations" do

    before do
      @order = Factory(:line_item).order
    end

    it "belongs_to a person (customer)" do
      @order.should respond_to(:customer)
    end

    it "has a customer which is a type of Person" do
      @order.customer.should be_kind_of(Person)
    end

    it "has many line_items" do
      @order.should respond_to(:line_items)
      @order.line_items.should be_kind_of(Array)
    end

    end

end
