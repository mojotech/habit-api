@javascript
Feature: Authentication
  As a user, I want to login so that I can manage my personal habits.

  If I have existing habits I should be brought to a list of my habits,
  otherwise I should be brought to a form to enter a new habit.

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

Scenario: Successful login with no habits
  Given a logged in account with the following information:
    | email    | dev@mojotech.com |
    | password | password         |
  When I click the logout link
  And I login with the following information:
    | email    | dev@mojotech.com |
    | password | password         |
  Then I should see a form to add a new habit

Scenario: Successful login with habits
  Given a logged in account with the following information:
    | email    | dev@mojotech.com |
    | password | password         |
  And the account "dev@mojotech.com" has the following habits:
    | title       | unit    | private |
    | walk dog    | times   | true    |
    | drink water | glasses | true    |
  When I click the logout link
  And I login with the following information:
    | email    | dev@mojotech.com |
    | password | password         |
  Then I should see the following habits:
    | title       |
    | walk dog    |
    | drink water |
