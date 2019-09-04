class UsersController < ApplicationController
  def index
    @post = current_user.posts.build
    @feed = current_user.feed.paginate(page: params[:page], per_page: 2)

    @users = User.where.not(id: current_user.id).reject do |user|
      user.friend?(current_user) || user.pending_request?(current_user)
    end
    @received_requests = current_user.received_requests
    @sent_requests = current_user.sent_requests
    @friends = current_user.all_friends
  end

  def show
    @user = current_user
  end
end
