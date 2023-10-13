class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  validates :title, presence: true
  validates :content, presence: true

  has_many :likes
  has_many :likers, through: :likes, source: :user
end
