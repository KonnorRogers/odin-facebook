# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_post

  def create
    @post.likes.find_or_create_by(user: current_user)

    send_notification(@post)

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

  def send_notification(post)
    # Send notification only if the creator of the post
    # if the current user
    return if post.author == current_user

    Notification.create(recipient: post.author, sender: current_user,
                        action: 'liked your', notifiable: post)
  end
end
