class UsersController < ApplicationController
  def index
    if user_signed_in?
      @post = current_user.posts.build
      @users = User.where.not(id: current_user.id).reject do |user|
        user.friend?(current_user) || user.pending_request?(current_user)
      end
      @received_requests = current_user.received_requests
      @sent_requests = current_user.sent_requests
      @friends = current_user.all_friends
    else
      redirect_to signup_path
    end
  end

  def show
    @user = current_user
  end
end
