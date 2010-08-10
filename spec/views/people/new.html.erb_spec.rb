require 'spec_helper'

describe "/people/new.html.erb" do
  include PeopleHelper

  before(:each) do
    person = Factory.build(:person)
    person.addresses.build
    assigns[:person] = person
  end

  it "renders new person form" do
    render
    response.should have_tag("form[action=?][method=post]", people_path) do
      with_tag("input#person_first_name[name=?]", "person[first_name]")
      with_tag("input#person_middle_name[name=?]", "person[middle_name]")
      with_tag("input#person_last_name[name=?]", "person[last_name]")
      with_tag("input#person_addresses_attributes_0_street[name=?]", "person[addresses_attributes][0][street]")
      with_tag("input#person_addresses_attributes_0_city[name=?]", "person[addresses_attributes][0][city]")
      with_tag("input#person_addresses_attributes_0_state[name=?]", "person[addresses_attributes][0][state]")
      with_tag("input#person_addresses_attributes_0_zip[name=?]", "person[addresses_attributes][0][zip]")
    end
  end
end
