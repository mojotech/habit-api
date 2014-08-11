@javascript
Feature: Account settings
  As a user, I want to be able to change my display name
  and password from an account settings page.

Background:
  Given I am logged in
  And I view my account settings

Scenario: Account settings page
  When I view my account settings
  Then I should be able to change my password
  And I should be able to change my display name

Scenario: Default display name
  Then my display name should be my email

Scenario: Change display name
  When I change my display name
  And I submit the form
  Then my display name should be changed

Scenario: Blank display name
  When I change my display name to be empty
  And I submit the form
  Then my display name should not be changed
  And I should be told to provide a valid display name

Scenario: Change password
  When I provide my current password
  And I enter and confirm a new password
  And I submit the form
  Then my password should be changed

Scenario: Wrong current password
  When I provide the wrong current password
  And I enter and confirm a new password
  And I submit the form
  Then my password should not be changed
  And I should be told my current password is incorrect
