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
end
