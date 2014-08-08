class HabitSerializer < ActiveModel::Serializer
  attributes :id, :title, :unit, :private, :user_count, :value, :past_tense

  def user_count
    object.users.count
  end

  def my_checkins
    object.checkins.where(user_id: current_user.id)
  end

  def value
    if my_target
      my_checkins
        .where(created_at: my_target.timeframe_int.days.ago..Time.now)
        .inject(0) { |sum, n| sum + n.value }
    else
      0
    end
  end

  def my_target
    object.targets.where(user_id: current_user.id).first
  end

  def total_progress
    my_checkins.inject(0) { |sum, n| sum + n.value }
  end
end
