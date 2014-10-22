class HabitSerializer < ActiveModel::Serializer
  attributes :id, :title, :private, :user_count, :value, :past_tense, :target, :last_checkin_value, :belongs_to_current_user

  def user_count
    object.users.count
  end

  def my_checkins
    object.checkins.where(user_id: current_user.id)
  end

  def belongs_to_current_user
    object.users.include?(current_user)
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

  def last_checkin_value
    if my_checkins.length >= 1
      my_checkins.first.value
    else
      1
    end
  end

end
