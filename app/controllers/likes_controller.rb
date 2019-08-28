class LikesController < ApplicationController
  before_action :find_post

  def create
    @post.likes.create(user_id: current_user)

    respond_to do |fmt|
      fmt.html { redirect_to root_url }
      fmt.js
    end
  end

  def delete
    @post.likes.find(params[:id]).destroy

    respond_to do |fmt|
      fmt.html { redirect_to root_url }
      fmt.js
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
