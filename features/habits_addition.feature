@javascript
Feature: Habits
  As a user, I want to add new habits to my list so I can
  keep track of my activities.

Background:
  Given I am logged in

Scenario: Create habit I already have
  Given that I created a public habit
  And I try to create a habit with the same title
  Then I should see an error message


Scenario: Suggestions for public habits
  Given there is a public habit "drink water"
  When I visit the new habits page
  And I type "drink wate" into the title field
  Then I should see a suggestion for "drink water"

Scenario: Join public habit
  Given there is a public habit "drink water"
  When I visit the new habits page
  And I type "drink wate" into the title field
  And I click the suggestion for "drink water"
  And I should be able to unjoin the public habit

Scenario: Unjoin public habit
  Given there is a public habit "drink water"
  When I visit the new habits page
  And I type "drink wate" into the title field
  And I click the suggestion for "drink water"
  And I cancel out of the public habit

Scenario: Home link if habits
  Given I created the following habits:
    | title       | unit    | private | target | timeframe |
    | walk dog    | times   | true    | 7      | week      |
  When I visit the new habits page
  Then I should see a link to return home

Scenario: Habit without title
  When I create a habit without a title
  Then I should be told to provide a title

Scenario: Habit without target unit
  When I create a habit without a target unit
  Then I should be told to provide a target unit

Scenario: Don't suggest my habits
  Given I created a new habit
  When I visit the new habits page
  And I type part of the habit's title into the title field
  Then I shouldn't see a suggestion for the habit
