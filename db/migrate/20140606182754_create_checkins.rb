class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :value
      t.belongs_to :habit
    end
  end
end
