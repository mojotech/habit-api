ActiveRecord::Schema.define(version: 20140606182754) do

  enable_extension "plpgsql"

  create_table "checkins", force: true do |t|
    t.integer "value"
    t.integer "habit_id"
  end

  create_table "habits", force: true do |t|
    t.string "title"
  end

end
