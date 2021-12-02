class SerializablePost < JSONAPI::Serializable::Resource
  type 'posts'
  attributes :user_ip, :title, :content

  attribute :user do
    user = User.where(id: @object.user_id).first
    user.login
  end
end
