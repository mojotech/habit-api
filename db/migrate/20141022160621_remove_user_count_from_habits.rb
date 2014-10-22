class RemoveUserCountFromHabits < ActiveRecord::Migration
  def change
    remove_column :habits, :user_count
  end
end
