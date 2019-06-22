class UsersController < ApplicationController
  def index
    if user_signed_in?
      redirect_to signup_path
    else
      # @sent_requests = current_user.sent_requests
      # @received_requests = current_user.received_requests
      # @friends = current_user.all_friends
    end
  end
end
