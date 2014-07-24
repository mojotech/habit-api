@javascript
Feature: Authentication
  As a user, I want to login so that I can view my personal habits. I should also be able to sign up for a new account and log out of a logged in account.

  Scenario: Login with unexisting account
    When I login with the following information:
      | email    | asdfljasdlfkj@asdflklkj.com |
      | password | password                    |
    Then I should be brought to the login form

  Scenario: Login with wrong password
    When I login with the following information:
      | email    | dev@mojotech.com |
      | password | abcd1234         |
    Then I should be brought to the login form

  Scenario: Successful login with habits
    Given the account dev@mojotech.com exists
    And the account dev@mojotech.com has the following habits:
      | title       | unit    | private |
      | walk dog    | times   | true    |
      | drink water | glasses | true    |
    When I login with the following information:
      | email    | dev@mojotech.com |
      | password | password         |
    Then I should see a list of my habits

  Scenario: Successful login with no habits
    Given the account dev@mojotech.com exists
    And the account dev@mojotech.com has no habits
    When I login with the following information:
      | email    | dev@mojotech.com |
      | password | password         |
    Then I should see a form to add a new habit

