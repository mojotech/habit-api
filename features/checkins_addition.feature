@javascript
Feature: Checkins
  As a user, I want to checkin to my habits to record my progress. I should be able to increment/decrement the checkin value of a habit by a given number of units.

  Background:
    Given I signup with the following information:
      | email    | dev@mojotech.com |
      | password | password         |

  Scenario: Positive checkin from habit details
    Given I visit the new habits page
    And I create a habit with the following information:
      | title   | walk dog |
      | unit    | times    |
      | private | true     |
    And I view the habit details for "walk dog"
    When I checkin positively with a value of 2
    Then I should see a checkin value of "2 times"

  Scenario: Negative checkin from habit details
    Given I visit the new habits page
    And I create a habit with the following information:
      | title   | walk dog |
      | unit    | times    |
      | private | true     |
    And I view the habit details for "walk dog"
    When I checkin negatively with a value of 3
    Then I should see a checkin value of "-3 times"
