class UsersController < ApplicationController
  def index
    redirect_to signup_path unless user_signed_in?
    @sent_requests = current_user.sent_requests
    @received_requests = current_user.received_requests
    @friends = current_user.all_friends
  end
end
