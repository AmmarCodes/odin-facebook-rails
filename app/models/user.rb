class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :friendships
  has_many :friends, -> { where(friendships: { confirmed: true }) }, through: :friendships
  has_many :friend_requests, -> { where(friendships: { confirmed: false }) }, source: :friend, through: :friendships
  has_many :notifications, -> { where(notifications: { done: false }) }
  has_many :posts
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post

  def can_send_friend_request(user)
    return false if self == user

    return false if friend_requests.include?(user)

    return false if friends.include?(user)

    true
  end

  def pending_friend_request_approval?(user)
    user.friend_requests.include?(self)
  end

  def sent_friend_request?(user)
    return true if friend_requests.include?(user)

    false
  end

  def has_friend?(user)
    friends.include?(user)
  end
end
