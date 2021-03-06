@javascript
Feature: Checkins
  As a user, I want to checkin to my habits to record my progress. I should be able to increment/decrement the checkin value of a habit by a given number of units.

  Background:
    Given I am logged in
    And I visit the new habits page

  Scenario: Custom positive checkin from habit details
    And I create a habit with the following information:
      | title     | walk dog |
      | unit      | times    |
      | private   | true     |
      | target    | 3        |
      | timeframe | day      |
    And I view the habit details for "walk dog"
    When I checkin with a value of 2
    Then I should see a checkin value of "2 times"
    Then the form should show a checkin value of 2

  Scenario: Initial positive checkin from list
    And I create a habit with the following information:
      | title     | walk dog |
      | unit      | times    |
      | private   | true     |
      | target    | 4        |
      | timeframe | day      |
    When I add a positive checkin to the habit with title "walk dog"
    Then The habit with title "walk dog" should have a checkin percentage of 25%

  Scenario: Checkin without value
    And I create a habit with the following information:
      | title     | walk dog |
      | unit      | times    |
      | private   | true     |
      | target    | 3        |
      | timeframe | day      |
    And I view the habit details for "walk dog"
    When I checkin with a value that is not an integer
    Then I should be told to provide a valid checkin value

  Scenario: Initial positive checkin from habit details
    And I create a habit with the following information:
      | title     | walk dog |
      | unit      | times    |
      | private   | true     |
      | target    | 4        |
      | timeframe | day      |
    And I view the habit details for "walk dog"
    Then I should see a default form checkin value of 1
    When I checkin without changing the default value
    Then the form should show a checkin value of 1

  Scenario: Custom positive checkin from list
    And I create a habit with the following information:
      | title     | walk dog |
      | unit      | times    |
      | private   | true     |
      | target    | 4        |
      | timeframe | day      |
    And I view the habit details for "walk dog"
    When I checkin with a value of 5
    When I view the habit list
    Then The habit list item with the title "walk dog" should have a checkin value of 5