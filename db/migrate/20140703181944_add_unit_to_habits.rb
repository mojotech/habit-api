class AddUnitToHabits < ActiveRecord::Migration
  def change
    add_column :habits, :unit, :string
  end
end
