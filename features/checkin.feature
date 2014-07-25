@entity @pending

Feature: Checkin

  Checkins represent the action of recording data associated with a habit.

  Checkins have a value which can be positive or negative.

  A user's habit value is determined by reducing all the checkins associated with that
  user and habit together.

  Checkins have notes associated with them. When browsing a public habit, users can
  see the checkin notes and values of other users that share the same goal. Users can
  reply to a checkin note.

  Scenario: checkins in a public habit are viewable by other users with the same habit
