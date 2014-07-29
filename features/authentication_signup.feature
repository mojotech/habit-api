@javascript
Feature: Authentication
  As a user, I want to signup for an account so I can begin managing my
  personal habits.

  Upon signup I should be logged in and brought to a form
  to enter a new habit.

Scenario: Signup with existing account
  When I signup with the following information:
    | email    | dev@mojotech.com |
    | password | password         |
  And I click the logout link
  When I signup with the following information:
    | email    | dev@mojotech.com |
    | password | password         |
  Then I should be brought to the signup form

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
