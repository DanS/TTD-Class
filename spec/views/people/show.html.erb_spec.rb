require 'spec_helper'

describe "/people/show.html.erb" do
  include PeopleHelper
  before(:each) do
    assigns[:person] = @person = Factory(:person)
    assigns[:items] = (1..3).collect {Factory(:item)}
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/#{@person.first_name}/)
    response.should have_text(/#{@person.last_name}/)
    response.should have_text(/#{@person.middle_name}/)
    end

  it "should display item names" do
    assigns[:items] = items = (1..3).collect {Factory(:item)}
    render
    response.should have_text(/#{items[0].name}/)
    response.should have_text(/#{items[1].name}/)
    response.should have_text(/#{items[2].name}/)
  end
end
