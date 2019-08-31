class LikesController < ApplicationController
  before_action :set_post

  def create
    @post.likes.find_or_create_by(user_id: current_user.id)

    respond_to do |fmt|
      fmt.html { redirect_to root_url }
      fmt.json
    end
  end

  def destroy
    @post.likes.where(user_id: current_user.id).destroy_all

    respond_to do |fmt|
      fmt.html { redirect_to root_url }
      fmt.json { render status: :created }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
