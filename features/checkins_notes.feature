@javascript
Feature: Checkins Notes
  As a user, I want to add an optional note when I checkin to a habit. I can
  also view the notes of other users that checked into a public habit, as well
  as notes on my private habit checkins.

Background:
  Given I am logged in

Scenario: Note field on habit details
  Given that I created a habit
  When I view the habit's details
  Then I should be able to enter a note with a checkin

Scenario: Add note to private habit
  Given that I created a habit
  And I checkin with a note
  Then I should see the note in the checkins list

Scenario: Add note to shared habit
  Given that I created a public habit
  When I checkin with a note
  Then other users with that habit should see the note
