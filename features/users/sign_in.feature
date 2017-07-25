Feature: Sign in

  Background:
    Given I exist as a user
    And I am not logged in
  
  Scenario: User signs in successfully
    When I sign in with valid credentials
    Then I return to the index page
    And I see a successful sign in message
    And I should be signed in

  Scenario: User enters wrong email
    When I sign in with a wrong email
    Then I am still in sign in page
    And I see an invalid login message
    And I should be signed out
    
  Scenario: User enters wrong password
    When I sign in with a wrong password
    Then I am still in sign in page
    And I see an invalid login message
    And I should be signed out
