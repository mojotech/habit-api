class HabitSerializer < ActiveModel::Serializer
  attributes :id, :title, :private, :user_count, :value, :past_tense, :target

  def my_checkins
    object.checkins.where(user_id: current_user.id)
  end

  def value
    if target
      my_checkins
        .where(created_at: target.timeframe_int.days.ago..Time.now)
        .inject(0) { |sum, n| sum + n.value }
    else
      0
    end
  end

  def target
    object.targets.where(user_id: current_user.id).first
  end
end
