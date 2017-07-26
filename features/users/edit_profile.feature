Feature: Edit profile

  Background:
    Given I am logged in
    Given I am in edit page
  
  Scenario: I edit my name
    When I edit my name
    And I submit edit form
    Then I return to the index page
    And I see an account edited message

  Scenario: I edit my password
    When I edit my password
    And I submit edit form
    Then I return to the index page
    And I see an account edited message

  Scenario: I edit my name without current password
    When I edit my name without current password
    And I submit edit form
    Then I see a current password missing message

  Scenario: I edit my password without current password
    When I edit my password without current password
    And I submit edit form
    Then I see a current password missing message

  Scenario: I edit my password without password confirmation
    When I edit my password without password confirmation
    And I submit edit form
    Then I see a mismatched password confirmation message

  Scenario: I edit my password with mismatched confirmation
    When I edit my password with mismatched confirmation
    And I submit edit form
    Then I see a mismatched password confirmation message

  Scenario: I edit my profile with invalid new password
    When I edit my profile with invalid new password
    And I submit edit form
    Then I see a invalid password message

  Scenario: I edit my profile with invalid current password
    When I edit my profile with invalid current password
    And I submit edit form
    Then I see a invalid current password message
