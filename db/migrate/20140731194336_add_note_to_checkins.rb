class AddNoteToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :note, :string
  end
end
