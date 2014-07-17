class AddTimestampsToModels < ActiveRecord::Migration
  def change
    add_column :habits, :created_at, :datetime
    add_column :habits, :updated_at, :datetime
    add_column :checkins, :created_at, :datetime
    add_column :checkins, :updated_at, :datetime
  end
end
