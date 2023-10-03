class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # def self.confirm
  #   self.class.create(user_id: self.friend.id, friend_id: self.user.id)
  # end
end
