@javascript
Feature: Account settings
  As a user, I want to be able to change my display name
  from an account settings page.

Background:
  Given I am logged in to a new account

Scenario: Account settings page
  When I view my account settings
  And I should be able to change my display name

Scenario: Default display name
  When I view my account settings
  Then my display name should not be blank

Scenario: Change display name
  When I view my account settings
  And I change my display name
  And I submit the form
  Then my display name should be changed

Scenario: Blank display name
  When I view my account settings
  And I change my display name to be empty
  And I submit the form
  Then I should be told to provide a valid display name
  And my display name should not be changed
