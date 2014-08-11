@javascript
Feature: Checkins
  As a user, I want to checkin to my habits to record my progress. I should be able to increment/decrement the checkin value of a habit by a given number of units.

  Background:
    Given I am logged in
    And I visit the new habits page

  Scenario: Positive checkin from habit details
    And I create a habit with the following information:
      | title     | walk dog |
      | unit      | times    |
      | private   | true     |
      | target    | 3        |
      | timeframe | day      |
    And I view the habit details for "walk dog"
    When I checkin with a value of 2
    Then I should see a checkin value of "2 times"
    And the form should be cleared

  Scenario: Positive checkin from list
    And I create a habit with the following information:
      | title     | walk dog |
      | unit      | times    |
      | private   | true     |
      | target    | 3        |
      | timeframe | day      |
    When I add a positive checkin to the habit with title "walk dog"
    Then The habit with title "walk dog" should have a checkin value of 1

  Scenario: Checkin without value
    And I create a habit with the following information:
      | title     | walk dog |
      | unit      | times    |
      | private   | true     |
      | target    | 3        |
      | timeframe | day      |
    And I view the habit details for "walk dog"
    When I checkin without value that is not an integer
    Then I should be told to provide a valid checkin value
