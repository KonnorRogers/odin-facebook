# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(
      recipient_id: current_user.id
    ).non_friend_requests

    @unread_notifications = @notifications.unread

    respond_to do |format|
      format.html { @notifications }
      format.json { @unread_notifications }
    end
  end

  def mark_as_read
    @unread_notifications = Notification.where(recipient: current_user).unread
    @unread_notifications.update_all(read_at: Time.zone.now)
    render json: { success: true }
  end
end
