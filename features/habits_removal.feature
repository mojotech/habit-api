@javascript
Feature: Habits
  As a user, I want to remove habits from my list that I no longer
  wish to track progress for.

Background:
  Given I am logged in

Scenario: Remove last habit
  Given I created the following habits:
    | title       | unit  | private |
    | walk dog    | times | true    |
  And I view the habit details for "walk dog"
  And I delete the habit
  Then I should see a form to add a new habit

Scenario: Remove habit with more remaining
  Given I created the following habits:
    | title       | unit    | private |
    | walk dog    | times   | true    |
    | drink water | glasses | true    |
  And I view the habit details for "walk dog"
  And I delete the habit
  Then I should not see the habit "walk dog" in my list
