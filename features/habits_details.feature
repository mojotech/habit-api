@javascript
Feature: Habits
  As a user, I want to click on a habit to view a detailed view of 
  that habit.

Background:
    Given I am logged in

Scenario: View habit details
  Given I created the following habits:
    | title    | unit  | private | target | timeframe |
    | walk dog | times | true    | 7      | week      |
  And I click the habit with the title "walk dog"
  Then I should see details for the habit "walk dog"
