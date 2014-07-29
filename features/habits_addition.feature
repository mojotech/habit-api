@javascript
Feature: Habits
  As a user, I want to add new habits to my list so I can
  keep track of my activities.

Background:
  Given I am logged in

Scenario: New habit link
  Given I created the following habits:
    | title    | unit     | private |
    | walk dog | times    | true    |
  Then I should see a link to add a new habit

Scenario: New habit form
  When I visit the new habits page
  Then I should see a form to enter a new habit

Scenario: Create new public habit
  When I visit the new habits page
  And I create a habit with the following information:
    | title   | walk dog  |
    | unit    | times     |
    | private | false     |
  Then I should should see the following habit in my list:
    | walk dog |

Scenario: Create new private habit
  When I visit the new habits page
  And I create a habit with the following information:
    | title   | drink water |
    | unit    | glasses     |
    | private | true        |
  Then I should should see the following habit in my list:
    | drink water |

Scenario: Create habit I already have
  Given I created the following habits:
    | title       | unit    | private |
    | walk dog    | times   | true    |
    | drink water | glasses | false   |
  When I visit the new habits page
  And I create a habit with the following information:
    | title   | drink water |
    | unit    | glasses     |
    | private | false       |
  Then I should see the habit "drink water" once in my list