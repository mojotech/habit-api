class Target < ActiveRecord::Base
  belongs_to :habit
  belongs_to :user

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
