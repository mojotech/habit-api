class TargetSerializer < ActiveModel::Serializer
  attributes :id, :value, :timeframe, :user_id, :habit_id, :unit, :completion
end
