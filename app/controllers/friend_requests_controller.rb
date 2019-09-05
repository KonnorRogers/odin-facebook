# frozen_string_literal: true

class FriendRequestsController < ApplicationController
  def index
    @received_requests = current_user.received_requests
    @sent_requests = current_user.sent_requests
    @unread_requests = Notification.where(
      recipient_id: current_user.id
    ).friend_requests.unread

    respond_to do |format|
      format.html { @received_requests }
      format.json { @unread_requests }
    end
  end

  def create
    @friend = User.find(params[:friend_id])
    @friendship = current_user.friend_requests.build(friend: @friend)
    if @friendship.save
      flash[:notice] = "Friend request sent to #{@friend.full_name}"
    else
      flash[:error] = 'Unable to add friend'
    end

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js
    end
  end

  def destroy
    @friend = User.find(params[:id])
    @friend_request = current_user.friend_requests.find_by(friend: @friend)
    @friend_request.destroy
    flash[:notice] = "Cancelled friend request to #{@friend.full_name}"

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def mark_as_read
    @unread_requests = Notification.where(
      recipient: current_user
    ).friend_requests.unread

    @unread_requests.update_all(read_at: Time.zone.now)
    render json: { success: true }
  end
end
