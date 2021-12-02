class Post < ApplicationRecord
  validates :title, :user_ip, :content, presence: true
end
