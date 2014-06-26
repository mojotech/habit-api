class AddUserToHabits < ActiveRecord::Migration
  def change
    add_column :habits, :user_id, :integer, index: true
  end
end
