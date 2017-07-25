Feature: Sign out

  Scenario: User signs out
    Given I am logged in
    When I sign out
    Then I return to the index page
    And I see a signed out message
    And I should be signed out
