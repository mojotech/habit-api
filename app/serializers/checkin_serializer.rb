class CheckinSerializer < ActiveModel::Serializer
  def display_name
    object.user.display_name
  end

  attributes :id, :value, :created_at, :user_id, :note, :display_name
end
