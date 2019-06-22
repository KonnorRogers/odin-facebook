class UsersController < ApplicationController
  def index
    if user_signed_in?
      @users = User.all
      @received_requests = current_user.received_requests
      @sent_requests = current_user.sent_requests
      @friends = current_user.all_friends
    else
      redirect_to signup_path
    end
  end
end
