class Target < ActiveRecord::Base
  belongs_to :habit
  belongs_to :user

  validates_inclusion_of :timeframe, in: ['week', 'month', 'day']
  validates :value, numericality: { only_integer: true }
  validates :unit, presence: true

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

end
