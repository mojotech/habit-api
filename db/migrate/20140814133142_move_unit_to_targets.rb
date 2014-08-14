class MoveUnitToTargets < ActiveRecord::Migration
  def up
    add_column :targets, :unit, :string
    Habit.find_each do |habit|
      habit.targets.find_each do |target|
        target.update_attribute :unit, habit.unit
      end
    end
    remove_column :habits, :unit
  end

  def down
    add_column :habits, :unit, :string
    Habit.find_each do |habit|
      habit.update_attribute :unit, habit.targets.first.unit
    end
    remove_column :targets, :unit
  end
end
