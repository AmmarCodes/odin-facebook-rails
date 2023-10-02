# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user_param, only: %I[show send_friend_request]

  def show
    @can_send_friend_request = can_send_friend_request(@user)
  end

  def send_friend_request
    # @TODO process
  end

  private

  def set_user_param
    @user = User.find(params[:id])
  end

  def can_send_friend_request(user)
    return false if current_user == user

    # @TODO return false if current_user.friends.include(user)

    true
  end
end
