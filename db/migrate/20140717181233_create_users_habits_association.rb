class CreateUsersHabitsAssociation < ActiveRecord::Migration
  def change
    create_table :habits_users, id: false do |t|
      t.belongs_to :habit, index: true
      t.belongs_to :user, index: true
    end
    remove_column :habits, :user_id
  end
end
