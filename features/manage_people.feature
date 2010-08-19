Feature: Manage people
  In order to manage peoples names and addresses
  As a person with friends and colleagues I
  want to create/edit/view/destroy people in the address book
  
  Scenario: Register new list_people
    Given I am on the new person page
    When I fill in "First name" with "first_name 1"
    And I fill in "Middle name" with "middle_name 1"
    And I fill in "Last name" with "last_name 1"
    And I fill in "Street" with "1234 First Street"
    And I fill in "City" with "San Francisco"
    And I fill in "State" with "CA"
    And I fill in "Zip" with "98765"
    And I press "Save changes"
    Then I should see "first_name 1"
    And I should see "middle_name 1"
    And I should see "last_name 1"

  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
  # dialogs.
  #
  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
  # detect the presence of Javascript behind Delete links and issue a DELETE request 
  # instead of a GET request.
  #
  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
  # will also turn off the emulation. (See the Capybara documentation for 
  # details about those tags). If any of the browser tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner 
  # after the scenario has finished. This is to prevent data from leaking into 
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #
  Scenario: Delete people
    Given the following people:
      |first_name|middle_name|last_name|
      |first_name 1|middle_name 1|last_name 1|
      |first_name 2|middle_name 2|last_name 2|
      |first_name 3|middle_name 3|last_name 3|
      |first_name 4|middle_name 4|last_name 4|
    When I delete the 3rd people
    Then I should see the following people:
      |First name|Middle name|Last name|
      |first_name 1|middle_name 1|last_name 1|
      |first_name 2|middle_name 2|last_name 2|
      |first_name 4|middle_name 4|last_name 4|
