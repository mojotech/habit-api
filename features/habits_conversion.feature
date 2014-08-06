@javascript

Feature: Habit Conversion

  As a user I want to change a private habit to public, or vice versa.

  Background:
    Given I am logged in

  Scenario: Private to public
    Given that I create a private habit
    When I edit the habit to be public
    Then I should see the habit is public
    # And another user should be able to see the habit  # TODO add back in with typeahead

  Scenario: Public to private
    Given that I create a public habit
    When I edit the habit to be private
    Then I should see the habit is private
    And another user should not see the habit

  Scenario: Shared to private
    Given that I create a shared habit
    When I edit the habit to be private
    Then I should see the habit is private    
    # And another user should be able to see the habit   # TODO add back in with typeahead
