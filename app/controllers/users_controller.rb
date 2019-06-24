class UsersController < ApplicationController
  def index
    if user_signed_in?
      @users = User.where.not(id: current_user.id).reject do |user|
        user.friend?(current_user) || user.pending_request?(current_user)
      end
      @received_requests = current_user.received_requests
      @sent_requests = current_user.sent_requests
      @friendships = current_user.all_friendships
    else
      redirect_to signup_path
    end
  end

  def show
    @user = current_user
  end
end
