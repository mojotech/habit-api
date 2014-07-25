@javascript
Feature: Authentication
  As a user, I want to login so that I can view my personal habits. I should also be able to sign up for a new account and log out of a logged in account.

  Scenario: Signup with existing account
    When I signup with the following information:
      | email    | dev@mojotech.com |
      | password | password         |
    And I click the logout link
    When I signup with the following information:
      | email    | dev@mojotech.com |
      | password | password         |
    Then I should be brought to the signup form

  Scenario: Log out
    When I signup with the following information:
      | email    | dev@mojotech.com |
      | password | password         |
    And I click the logout link
    Then I should be brought to the login form

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
    When I signup with the following information:
      | email    | dev@mojotech.com |
      | password | password         |
    And I click the logout link
    And I login with the following information:
      | email    | dev@mojotech.com |
      | password | password         |
    Then I should see a form to add a new habit

  Scenario: Successful login with habits
    When I signup with the following information:
      | email    | dev@mojotech.com |
      | password | password         |
    And I create the following habits:
      | title       | unit    | private |
      | walk dog    | times   | true    |
      | drink water | glasses | true    |
    And I click the logout link
    And I login with the following information:
      | email    | dev@mojotech.com |
      | password | password         |
    Then I should see the following habits:
      | title       |
      | walk dog    |
      | drink water |

  Scenario: Successful signup
    When I signup with the following information:
      | email    | dev@mojotech.com |
      | password | password         |
    Then I should see a form to add a new habit

  Scenario: Signup with invalid email
    When I signup with the following information:
      | email    | devmojotechcom |
      | password | password       |
    Then I should be brought to the signup form

  Scenario: Signup with invalid password
    When I signup with the following information:
      | email    | dev@mojotech.com |
      | password | 123              |
    Then I should be brought to the signup form
