class Target < ActiveRecord::Base
  belongs_to :habit, inverse_of: :targets
  belongs_to :user
  has_many :checkins

  validates_inclusion_of :timeframe, in: ['week', 'month', 'day']
  validates :value, numericality: { only_integer: true }
  validates :unit, :completion, presence: true

  validates_presence_of :habit
  accepts_nested_attributes_for :habit, reject_if: :habit_exists

  def timeframe_int
    case timeframe
    when "week"
      7
    when "month"
      30
    when "day"
      1
    else
      1
    end
  end

  def update_completion
    completion = self.user.checkins.where(
                   habit_id: self.habit_id,
                   created_at: self.timeframe_int.days.ago..Time.now
                 ).inject(0) { |sum, n| sum + n.value } / self.value.to_f
    self.update_attribute :completion, completion
  end

  private

  def habit_exists(attr)
    if _habit = Habit.find_by(title: attr['title'])
      self.habit = _habit
      true
    else
      false
    end
  end
end
