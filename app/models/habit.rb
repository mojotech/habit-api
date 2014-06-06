class Habit < ActiveRecord::Base
  has_many :checkins
end
