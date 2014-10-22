class MovePrivateToTarget < ActiveRecord::Migration
  def up
    remove_column :habits, :private
    add_column :targets, :private, :boolean
  end
  def down
    add_column :habits, :private, :boolean
    remove_column :targets, :private, :boolean
  end
end
