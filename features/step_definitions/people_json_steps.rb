require 'json'

When /^I add a person with: first="([^"]*)" middle="([^"]*)" last="([^"]*)" street="([^"]*)" city="([^"]*)" state="([^"]*)" zip="([^"]*)"$/ do |first, middle, last, street, city, state, zip|
  person = Factory(:person, :first_name=>first, :middle_name=>middle, :last_name=>last)
  Factory(:address, :street=>street, :city=>city, :state=>state, :zip=>zip, :person=>person)
end

When /^I request: ([^\s]+)$/ do |url| 
  visit url
end

Then /^I get a (\d+) \(([\s\w]+)\) status result$/ do |code, description|
  response.response_code.should == code.to_i
end

Then /^the response header content\-type matches "([^"]*)"$/ do |content_type|
  response.headers['Content-Type'].should match(%r{#{content_type}})
end

Then /^the response should match json:$/ do |expected_as_text|
  expected_json = JSON.parse expected_as_text
  response_json = JSON.parse response.body
#  p "---------- expected:"
#  p expected_json
#  p "---------- response:"
#  p response_json
  response_json.should == expected_json
end
