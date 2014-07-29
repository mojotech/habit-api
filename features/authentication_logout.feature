@javascript
Feature: Authentication
  As a user, I want to be able to logout of the system.

Scenario: Log out
  Given I am logged in
  When I click the logout link
  Then I should be brought to the login form
