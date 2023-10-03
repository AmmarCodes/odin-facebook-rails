# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user_param, only: %I[show send_friend_request]

  def show
    @can_send_friend_request = can_send_friend_request(@user)
  end

  def send_friend_request
    if can_send_friend_request(@user)
      current_user.friend_requests << @user
      flash[:notice] = 'Friend request sent!'
      # TODO: send notification to @user
    else
      flash[:alert] = 'You can not send a friend request to this user.'
    end
    redirect_back fallback_location: root_url
  end

  private

  def set_user_param
    @user = User.find(params[:id])
  end

  def can_send_friend_request(user)
    return false if current_user == user

    return false if current_user.friend_requests.include?(user)

    return false if current_user.friends.include?(user)

    true
  end
end
