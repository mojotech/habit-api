@javascript

Feature: Target Creation

  As a user I want to be able to set my target and see it in the
  habit details view. This allows me to compare my actual progress
  to my desired target.

Scenario: A user should be able to create a target
  Given I am logged in
  And I am a user creating a habit "Walk Dog" in "walks"
  When I set the target with
    | value | timeframe |
    | 45    | day       |
  And I click the habit with the title "Walk Dog"
  Then I should see the target "45 walks per day"
