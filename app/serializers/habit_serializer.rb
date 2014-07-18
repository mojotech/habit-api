class HabitSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :title, :unit, :private
  has_many :checkins
end
