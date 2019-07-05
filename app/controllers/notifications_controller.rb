class NotificationsController < ApplicationController
  def index
    @notifications = Notificaiton.where(recipient: current_user).unread
  end
end
