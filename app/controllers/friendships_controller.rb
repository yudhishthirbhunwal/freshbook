class FriendshipsController < ApplicationController

  def friends
    @friends = current_user.friends.page(params[:page]).per(20)
  end

  def create
    @friend = User.find_by(id: params[:friend_id])
    current_user.requested_friends << @friend
    redirect_back(fallback_location: root_url)
  end

  def update
    @friend = User.find_by(id: params[:id])
    @friendship = Friendship.find_by(user_id: current_user.id, friend_id: @friend.id)
    @friendship_rev = Friendship.find_by(user_id: @friend.id, friend_id: current_user.id)
    @friendship.accept_request
    @friendship_rev.accept_request
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @friend = User.find_by(id: params[:friend_id])
    current_user.friends.delete(@friend)
    @friend.friends.delete(current_user)
    redirect_back(fallback_location: root_url)
  end

end
