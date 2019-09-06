# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_post

  def create
    @post.likes.find_or_create_by(user_id: current_user.id)

    # Send notification
    Notification.create(recipient: @post.author, sender: current_user,
                        action: 'liked', notifiable: @post)

    respond_to do |fmt|
      fmt.html { redirect_back(fallback_location: root_url) }
      fmt.js
    end
  end

  def destroy
    @post.likes.where(user_id: current_user.id).destroy_all

    respond_to do |fmt|
      fmt.html { redirect_back(fallback_location: root_url) }
      fmt.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
