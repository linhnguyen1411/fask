Feature: Show index page

  Background:
    Given I am in index page
    Then I see text field search
    And I see dropdown change language
    And I see button home
    And I see button help
    And I see button mobile app
    And I see button search
    And I see choose item Qa-Knowledge
    And I see choose item Feedback
    And I see choose item Confesstion
    And I see choose item Post Question
    And I see choose item Recent Question
    And I see choose item Recently Answer
    And I see choose item Top Views
    And I see choose item Top Vote

  Scenario: User not sign in
    Given I am not logged in
    Then I see button login
    And I see button sign up
    And I dont see image avatar

  Scenario: User logged in
    Given I am logged in
    Then I dont see button login
    And I see image avatar
    And I dont see button sign up

  Scenario: Click logo
    Given I see logo
    When I am click logo
    Then Redirect to root page

  Scenario: Click button home
    When I am click button home
    Then Redirect to root page

  Scenario: Click button help
    When I am click button help
    Then Redirect to help page

  Scenario: Click button app mobile
    When I am click button app mobile
    Then Redirect to app mobile page

  Scenario: Click choose Qa-Knowledge
    When I am click choose Qa-Knowledge
    Then Redirect to Qa-Knowledge page

  Scenario: Click choose Feedback
    When I am click choose Feedback
    Then Redirect to Feedback page

  Scenario: Click choose Confesstion
    When I am click choose Confesstion
    Then Redirect to Confesstion page
