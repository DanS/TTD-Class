require 'spec_helper'

describe Order do

  it "should create a new instance given valid attributes" do
    Order.create!(Factory.attributes_for(:order))
  end

  context "associations" do

    before do
      @order = Factory(:order)
    end

    it "belongs_to a person (customer)" do
      @order.should respond_to(:customer)
    end

    it "has a customer which is a type of Person" do
      @order.customer.should be_kind_of(Person)
    end

  end

end
