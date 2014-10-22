class DropHabitUsersTable < ActiveRecord::Migration
  def change
    drop_table :habits_users
  end
end
