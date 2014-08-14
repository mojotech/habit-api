class Target < ActiveRecord::Base
  belongs_to :habit
  belongs_to :user
  has_many :checkins

  validates_inclusion_of :timeframe, in: ['week', 'month', 'day']
  validates :value, numericality: { only_integer: true }
  validates :unit, :completion, presence: true

  def timeframe_int
    case timeframe
    when "week"
      7
    when "month"
      30
    when "day"
      1
    end
  end

  def update_completion
    completion = self.user.checkins.where(
                   created_at: self.timeframe_int.days.ago..Time.now
                 ).inject(0) { |sum, n| sum + n.value } / self.value.to_f
    self.update_attribute :completion, completion
  end

end
