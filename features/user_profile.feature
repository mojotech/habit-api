@javascript
Feature: User Profile
  As a user I should be able to view other users profiles including the
  habits they are publicly tracking. When I view my own profile I should
  only see my public habits.

  When I look at another user's profile I should be able to see their
  public habits and join any that I do not currently track.

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
  When I view another user's profile page
  And I join a habit that I don't currently track
  Then the new habit form should include the title of that habit