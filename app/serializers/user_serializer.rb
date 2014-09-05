class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :display_name
end
