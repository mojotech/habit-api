class HabitSerializer < ActiveModel::Serializer
  embed :ids, include: true

  has_many :checkins
  has_many :users

  attributes :id, :title, :unit, :private, :user_count, :value

  def user_count
    object.users.count
  end
  def my_checkins
    object.checkins.where(user_id: current_user.id)
  end
  def value
    my_checkins.inject(0) { |sum, n| sum + n.value }
  end
end
