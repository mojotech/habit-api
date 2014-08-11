class AddDisplayNameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :display_name, :string
    User.find_each do |user|
      user.update_attribute :display_name, user.email[/[^@]+/]
    end
  end

  def down
    remove_column :users, :display_name
  end
end
