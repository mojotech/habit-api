@javascript
Feature: Habits
  As a user, I want to remove habits from my list that I no longer
  wish to track progress for.

Background:
  Given I am logged in

Scenario: Remove last habit
  Given I created the following habits:
    | title       | unit  | private | target | timeframe |
    | walk dog    | times | true    | 2      | day       |
  And I view the habit details for "walk dog"
  And I click the edit button
  When I delete the habit
  Then I should see a form to add a new habit

Scenario: Remove habit with more remaining
  Given I created the following habits:
    | title       | unit    | private | target | timeframe |
    | walk dog    | times   | true    | 2      | day       |
    | drink water | glasses | true    | 8      | day       |
  And I view the habit details for "walk dog"
  And I click the edit button
  When I delete the habit
  Then I should not see the habit "walk dog" in my list

Scenario: Cancel button for private habits
  Given that I created a private habit
  When I view the habit's details
  And I click the edit button
  Then I should see a delete button

Scenario: Cancel button for public habits
  Given that I created a public habit
  When I view the habit's details
  And I click the edit button
  Then I should see a delete button

Scenario: Abandon button for shared habits
  Given that I joined a shared habit
  When I view the habit's details
  And I click the edit button
  Then I should see an abandon button

# Scenario: Dissassociate from shared habit
#   Given that I joined a shared habit
#   When I abandon the shared habit
#   Then the other users still belong to the habit
