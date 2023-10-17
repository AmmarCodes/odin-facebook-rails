require 'digest'

# Copied from https://guides.rubyonrails.org/active_record_validations.html#custom-validators
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless URI::MailTo::EMAIL_REGEXP.match?(value)
      record.errors.add attribute, (options[:message] || "is not an email")
    end
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, on: :create, email: true

  has_many :friendships
  has_many :friends, -> { where(friendships: { confirmed: true }) }, through: :friendships
  has_many :friend_requests, -> { where(friendships: { confirmed: false }) }, source: :friend, through: :friendships
  has_many :notifications, -> { where(notifications: { done: false }) }
  has_many :posts
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments

  after_create :send_welcome_email

  def send_welcome_email
    UserMailer.with(user: self).welcome_email.deliver_later
  end

  def can_send_friend_request(user)
    return false if self == user

    return false if sent_friend_request?(user)

    return false if has_friend?(user)

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

  def gravatar_image
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{hash}"
  end
end
