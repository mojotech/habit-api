class HabitSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :title
  has_many :checkins
end
