@javascript

Feature: Target editing

  As a user I should be able to edit my target so that as I improve
  I can up my desired performance.

Scenario: A user should be able to edit a target
  Given I am logged in
  And a habit with the target
    | value | timeframe | unit  |
    | 45    | day       | times |
  When I edit the habit to be
    | value | timeframe | unit  |
    | 15    | week      | walks |
  Then I should see the target "15 walks per week"
