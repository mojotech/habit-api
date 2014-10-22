class TargetSerializer < ActiveModel::Serializer
  attributes :id, :private, :value, :timeframe, :user_id, :habit_id, :unit, :completion
end
