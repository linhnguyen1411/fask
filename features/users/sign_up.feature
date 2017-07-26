Feature: Sign up

  Background:
    Given I am not logged in

  Scenario: User signs up with valid data
    When I sign up with valid user data
    Then I return to the index page
    And I see a successfull sign up message

  Scenario: User signs up without email
    When I sign up without email
    Then I see a missing email message

  Scenario: User signs up without password
    When I sign up without password
    Then I see a missing password message

  Scenario: User signs up without password confirmation
    When I sign up without password confirmation
    Then I see a mismatched password confirmation message
    
  Scenario: User signs up with mismatched password and confirmation
    When I sign up with mismatched password confirmation
    Then I see a mismatched password confirmation message

  Scenario: User signs up with invalid password
    When I sign up with invalid password
    Then I see a invalid password message

  Scenario: User signs up with already exist email
    When I sign up with already exist email
    Then I see a already exist email message
