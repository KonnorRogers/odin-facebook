# frozen_string_literal: true

class FriendRequestsController < ApplicationController
  def index
    @received_requests = current_user.received_requests
    @sent_requests = current_user.sent_requests
    @unread_requests = FriendRequest.where(friend_id: current_user).unread
  end

  def create
    @friendship = current_user.friend_requests.build(friend_id: params[:friend_id])
    @friend = User.find(params[:friend_id])
    if @friendship.save
      flash[:notice] = "Friend request sent to #{@friend.full_name}"
    else
      flash[:error] = 'Unable to add friend'
    end

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end


  def destroy
    @friend_request = current_user.friend_requests.find_by(friend_id: params[:id])
    @friend = User.find(params[:id])
    @friend_request.destroy
    flash[:notice] = "Cancelled friend request to #{@friend.full_name}"

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def mark_as_read
    @unread_requests = Notifications.where(friend_id: current_user).unread
    @unread_requests.update_all(read_at: Time.zone.now)
    render json: { success: true }
  end
end
