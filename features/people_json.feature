Feature: People info via JSON
  In order to view people and addresses
  As a device or client app using the JSON REST interface
  I want to make GET requests to the person URL

  Scenario: get a list of people and addresses
    When I add a person with: first="Jon" middle="Q" last="Doe" street="13 Happy Lane" city="SF" state="CA" zip="12345"
    And I request: /people.json
    #Then I get a 200 (success) status result status code not available from capybara
    Then the response header content-type matches "application/json"
    And the response should match json:
   """
    { "request": "http://www.example.com/people.json",
      "people": [
         {
             "first_name": "Jon",
             "middle_name": "Q",
             "last_name": "Doe",
             "addresses": [
               {
                 "street":"13 Happy Lane",
                 "city":"SF",
                 "state":"CA",
                 "zip":"12345",
                 "country":"USA"
               }
             ]    
         }
        ] ,
     "status" : { "code": 200, "message":  "ok" }
    }
  """
