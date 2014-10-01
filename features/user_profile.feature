@javascript
Feature: User Profile
  As a user I should be able to view other users profiles
  including the habits they are publicly tracking. When I view my own profile I should only see my public habits.

Background:
  Given I am logged in

Scenario: View current user details
  And I have checked in to a public habit
  When I click my display name in the checkins list
  Then I should see my profile with my public habits

Scenario: View other user details from checkin list
  And that I join a shared habit with checkins
  When I click a user name from the checkins list
  Then I should see their user profile and public habits

