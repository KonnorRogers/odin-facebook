class UsersController < ApplicationController
  def index
    @post = current_user.posts.build
    @feed = current_user.feed.paginate(page: params[:page], per_page: 2)

    @users = User.where.not(id: current_user.id).reject do |user|
      user.friend?(current_user) || user.pending_request?(current_user)
    end
  end

  def show
    @user = User.find(params[:id])

    @post = current_user.posts.build if @user == current_user
    @feed = Post.where(author_id: @user.id).paginate(page: params[:page],
                                                     per_page: 2)
  end
end
