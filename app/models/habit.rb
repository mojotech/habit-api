class Habit < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :checkins, order: "created_at DESC"
end
