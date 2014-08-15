class AddUserCountToHabit < ActiveRecord::Migration
  def up
    add_column :habits, :user_count, :integer, index: true
    Habit.find_each do |habit|
      habit.save!
    end
  end
  def down
    remove_column :habits, :user_count
  end
end
