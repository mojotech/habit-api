class HabitSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :title, :unit
  has_many :checkins
end
