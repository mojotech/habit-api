class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.integer :value
      t.string :timeframe

      t.belongs_to :user
      t.belongs_to :habit

      t.timestamps
    end
  end
end
