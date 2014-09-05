class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :image, :display_name
end
