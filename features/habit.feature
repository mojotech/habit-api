@entity @pending

Feature: Habit

  Habits are the core of our application. They represent the action that a user wants
  to do more or less of.

  Habits can be public or private.

  When a public habit has more than one user, it is considered shared.

  When a habit is public, anyone can join that habit. This means that there should never
  be two public habits with the same title.

  Private habits are only accessible by the owner of the habit.

  Habits can be converted from public to private and vice versa.

  Public habits with only one user can be modified and deleted, once a public habit
  has more than one user it becomes a shared habit.

  Shared habits cannot have their title or unit modified. The privacy can be modified
  but in actuality this creates a new private habit and re-associates the checkins from
  the afformentioned habit to the new habit.

  Habits have a value which represent's the reduction of all checkins that belong to
  both the habit and user. This habit value is what a user uses to evaluate their progress.

  Scenario: Visibility
    * A habit can be private
    * A habit can be public
    * A habit can't have any other visibility
    * A habit's visibility must be set when the habit is created

  Scenario: Conversion
    * A shared habit can be converted to private
    * A public habit can be converted to private
    * A private habit can be converted to public

  Scenario: Public Editability
    * A public habit can have its attributes edited

  Scenario: Private Editability
    * A private habit can have its attributes edited

  Scenario: Shared Editiablity
    * Editing attributes of a shared habit creates a new habit with those attributes

  Scenario: Joinability
    * A public habit can be joined, creating a shared habit
