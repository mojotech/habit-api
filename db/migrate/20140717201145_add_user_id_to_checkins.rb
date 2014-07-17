class AddUserIdToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :user_id, :integer, index:true
  end
end
