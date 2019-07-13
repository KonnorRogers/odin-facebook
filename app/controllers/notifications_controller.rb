# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @all_notifications = Notification.where(recipient: current_user)
    @notifications = @all_notifications.unread
    @pending_requests = current_user.received_requests
  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: { success: true }
  end
end
