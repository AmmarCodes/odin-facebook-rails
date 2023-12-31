# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user_param, only: %I[send_friend_request approve_friend_request confirm_friend_request]

  def index
    @users = User.includes(:posts, :friends, :friend_requests, :liked_posts, friendships: %i[user friend]).all
  end

  def show
    @user = User.includes(posts: [:author, :likes, :likers, { comments: [:user] }]).find(params[:id])
  end

  def profile
    @user = current_user
    render 'users/edit'
  end

  def update
    @user = current_user
    if @user.update(params.require(:user).permit(:name, :email, :bio))
      redirect_to profile_url, notice: 'Your personmal information was successfully updated.'
    else
      render 'users/edit', status: :unprocessable_entity
    end
  end

  def friends
    @friends = User.includes(:friend_requests, friends: %I[posts liked_posts friends])
                   .find(current_user.id).friends
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
    render status: 404 unless @user
  end
end
