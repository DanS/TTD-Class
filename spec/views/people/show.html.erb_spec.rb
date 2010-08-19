require 'spec_helper'

describe "/people/show.html.erb" do
  include PeopleHelper
  before(:each) do
    @person = Factory(:person)
    assigns[:items] = (1..3).collect {Factory(:item)}
    @address = Factory(:address)
    @person.addresses = [@address]
    assigns[:person] = @person
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/#{@person.first_name}/)
    response.should have_text(/#{@person.last_name}/)
    response.should have_text(/#{@person.middle_name}/)
    response.should have_text(/#{@person.addresses.first.street}/)
    response.should have_text(/#{@person.addresses.first.city}/)
    response.should have_text(/#{@person.addresses.first.state}/)
    response.should have_text(/#{@person.addresses.first.zip}/)
    end

  it "should display item names" do
    assigns[:items] = items = (1..3).collect {Factory(:item)}
    render
    response.should have_text(/#{items[0].name}/)
    response.should have_text(/#{items[1].name}/)
    response.should have_text(/#{items[2].name}/)
  end
end
