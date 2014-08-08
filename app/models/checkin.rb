class Checkin < ActiveRecord::Base
  belongs_to :habit
  belongs_to :user

  validates :value, numericality: { only_integer: true }
end
