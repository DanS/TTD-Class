require 'spec_helper'

describe "/people/show.html.erb" do
  include PeopleHelper
  before(:each) do
    assigns[:person] = @person = stub_model(Person,
      :first_name => "value for first_name",
      :middle_name => "value for middle_name",
      :last_name => "value for last_name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ first_name/)
    response.should have_text(/value\ for\ middle_name/)
    response.should have_text(/value\ for\ last_name/)
  end
end
