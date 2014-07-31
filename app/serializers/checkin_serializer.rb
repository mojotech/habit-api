class CheckinSerializer < ActiveModel::Serializer
  def email
    object.user.email
  end

  attributes :id, :value, :email, :created_at, :user_id, :note
end
