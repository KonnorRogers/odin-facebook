class FriendRequestsController < ApplicationController
  def create
    @friendship = current_user.friend_requests.build(friend_id: params[:friend_id])
    @friend = User.find(params[:friend_id])
    if @friendship.save
      flash[:notice] = "You have sent a friend request to #{@friend.full_name}"
    else
      flash[:error] = 'Unable to add friend'
    end

    redirect_to root_url
  end

  def destroy
    @friendship = current_user.friend_requests.find(params[:id])
    @friend = User.find(params[:id])
    @friendship.destroy
    flash[:notice] = "You are no longer friends with #{@friend}"
    redirect_to root_url
  end
end
