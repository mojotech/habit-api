class AddTargetIdToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :target_id, :integer
  end
end
