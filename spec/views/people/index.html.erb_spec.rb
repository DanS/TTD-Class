require 'spec_helper'

describe "/people/index.html.erb" do
  include PeopleHelper

  before(:each) do
    assigns[:people] = [
      stub_model(Person,
        :first_name => "value for first_name",
        :middle_name => "value for middle_name",
        :last_name => "value for last_name"
      ),
      stub_model(Person,
        :first_name => "value for first_name",
        :middle_name => "value for middle_name",
        :last_name => "value for last_name"
      )
    ]
  end

  it "renders a list of people" do
    render
    response.should have_tag("tr>td", "value for first_name".to_s, 2)
    response.should have_tag("tr>td", "value for middle_name".to_s, 2)
    response.should have_tag("tr>td", "value for last_name".to_s, 2)
  end
end
