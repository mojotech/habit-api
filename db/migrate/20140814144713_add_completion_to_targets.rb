class AddCompletionToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :completion, :decimal, default: 0.0
  end
end
