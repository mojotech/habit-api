@javascript
Feature: Authentication
  As a user, I want to signup for an account so I can begin managing my
  personal habits.

  Upon signup I should be logged in and brought to a form
  to enter a new habit.

Scenario: Signup with existing account
  When I signup with the following information:
    | email        | dev@mojotech.com |
    | password     | password         |
    | display_name | Dylan            |
  And I logout
  When I signup with the following information:
    | email        | dev@mojotech.com |
    | password     | password         |
    | display_name | Dylan            |
  Then I should be brought to the signup form
  And I should be told the account already exists

Scenario: Successful signup
  When I signup with the following information:
    | email        | dev@mojotech.com |
    | password     | password         |
    | display_name | Dylan            |
  Then I should see a form to add a new habit

Scenario: Signup with invalid email
  When I signup with the following information:
    | email        | devmojotechcom |
    | password     | password       |
    | display_name | Dylan          |
  Then I should be brought to the signup form
  And I should be told to provide a valid email

Scenario: Signup with short password
  When I signup with the following information:
    | email        | dev@mojotech.com |
    | password     | 123              |
    | display_name | Dylan            |
  Then I should be brought to the signup form
  And I should be told to provide a longer password

Scenario: Signup with blank password
  When I signup with the following information:
    | email        | dev@mojotech.com |
    | display_name | Dylan            |
  Then I should be brought to the signup form
  And I should be told to provide a password

Scenario: Signup without display name
  When I signup with the following information:
    | email    | dev@mojotech.com |
    | password | password         |
  Then I should be brought to the signup form
  And I should be told to provide a display name
