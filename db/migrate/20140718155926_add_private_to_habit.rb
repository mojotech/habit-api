class AddPrivateToHabit < ActiveRecord::Migration
  def change
    add_column :habits, :private, :boolean
  end
end
