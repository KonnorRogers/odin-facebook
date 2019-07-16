# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(recipient_id: current_user.id).non_friend_requests
    respond_to do |format|
      format.html { @notifications }
      format.json { @notifications.unread }
    end
  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: { success: true }
  end
end
