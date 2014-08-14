class Checkin < ActiveRecord::Base
  belongs_to :habit
  belongs_to :user
  belongs_to :target

  validates :value, numericality: { only_integer: true }

  after_save :update_target_completion

  private
    def update_target_completion
      self.target.update_completion
    end
end
