@javascript
Feature: Authentication
  As a user, I want to reset my password if I forget it.

Scenario: Password reset email
  Given I created an account
  When I view the forgot password page
  And I enter my account information
  And I click the reset password button
  Then I should be sent an email to reset my password

Scenario: Unexisting account
  When I view the forgot password page
  And I enter an unexisting account
  And I click the reset password button
  Then I should be told the account is invalid

