class AddPastTenseToHabit < ActiveRecord::Migration
  def change
    add_column :habits, :past_tense, :string
  end
end
