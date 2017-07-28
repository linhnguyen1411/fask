Feature: Show index page

  Scenario: Question not exist
    Given server not have question
    Then I see message question not exist

  Scenario: Question exits
    Given server have question
    Then I see question
    And I see name of question
    And I see content of question
    And I see number view of question
    And I see number tag of question
    And I see number vote of question
    And I see button upvote question
    And I see button downvote question


  Scenario: Click button upvote question
    When I click button upvote
    Then I see number vote of question

  Scenario: Click button upvote question but I downvoted to question
    When I click button upvote but I downvoted to question
    Then I see message voted to question

  Scenario: Click button downvote question
    When I click button downvote
    Then I see number vote of question

  Scenario: Click button downvote question but I downvoted to question
    When I click button downvote but I downvoted to question
    Then I see message voted to question

  Scenario: Answer exits
    Given server have answers
    Then I see answers
    And I see number like of answer
    And I see number dislike of answer

  Scenario: Click button like answer
    When I click button like
    Then I see number like of answer reduced

  Scenario: Click button like answer but I liked to answer
    When I click button like but I liked to answer
    Then I see message liked to answer

  Scenario: Click button like answer but I disliked to answer
    When I click button like but I disliked to answer
    Then I see number like of answer
    And I see number dislike to answer

  Scenario: Click button dislike answer
    When I click button dislike
    Then I see number dislike of answer

  Scenario: Click button dislike question but I disliked to answer
    When I click button dislike but I disliked to answer
    Then I see message disliked to answer

  Scenario: Click button dislike answer but I liked to answer
    When I click button dislike but I liked to answer
    Then I see number dislike of answer
    And I see number like to answer

  Scenario: Create answer with content nil
    When I click button answer with content nil
    Then I see message create answer error

  Scenario: Create answer with present content
    When I click button answer with present content
    Then I see message  create answer success
    And I see content answer on page
