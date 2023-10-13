# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user_param, only: %I[show send_friend_request approve_friend_request confirm_friend_request]

  def show
    @can_send_friend_request = can_send_friend_request(@user)
  end

  def show; end

  def friends
    @friends = current_user.friends
  end

  def send_friend_request
    if current_user.can_send_friend_request(@user)
      current_user.friend_requests << @user
      flash[:notice] = 'Friend request sent!'
      # send notification to @user
      @user.notifications.create(friend_id: current_user.id)
    else
      flash[:alert] = 'You can not send a friend request to this user.'
    end
    redirect_back fallback_location: root_url
  end

  def confirm_friend_request
    # ensure there is a friend request in the first place
    request = @user.friendships.where(friend: current_user).where(confirmed: false).first
    raise 'no friendships request found' unless request

    # mark confirmed as true
    request.update(confirmed: true)
    # add opposite friendship relation
    opposite_relation = current_user.friendships.where(friend: @user).where(confirmed: false).first
    if opposite_relation
      opposite_relation.update(confirmed: true)
    else
      current_user.friends << @user
    end
    # mark notification as done
    current_user.notifications.where(friend: @user).update(done: true)
    # flash notice friend has been confirmed
    flash[:notice] = "You are now friend with #{@user.name}"

    redirect_back fallback_location: notifications_path
  end

  private

  def set_user_param
    @user = User.find(params[:id])
    render status:  404 unless @user
  end
end
