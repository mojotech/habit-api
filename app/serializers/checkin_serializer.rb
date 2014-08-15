class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :value, :created_at, :user_id, :note, :display_name, :belongs_to_user

  def display_name
    object.user.display_name
  end

  def belongs_to_user
    object.user == current_user
  end
end
