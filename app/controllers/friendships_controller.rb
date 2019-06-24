# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:id])
    @friend = User.find(params[:friend_id])
    if @friendship.save
      flash[:notice] = "You have accepted #{@friend.full_name}"
    else
      flash[:error] = 'Unable to add friend'
    end

    redirect_to root_url
  end

  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    @friend = User.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed #{@friend.full_name}"
    redirect_to root_url
  end
end
