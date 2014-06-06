class CreateHabits < ActiveRecord::Migration
  def change
    create_table :habits do |t|
      t.string :title
    end
  end
end
