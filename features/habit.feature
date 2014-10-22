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
