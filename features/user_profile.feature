@javascript
Feature: User Profile
  As a user I should be able to view other users profiles
  including the habits they are publicly tracking.
  If they have a habit that I am not tracking I should have the option to join that habit. When I view my own profile I should only see my public habits.

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

Scenario: Join a shared habit via user profile
  When I view a user profile page
  Then I should be able to join habits I don't currently track
  Then the new habit form should include the title of that habit