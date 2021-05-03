class FriendshipsController < ApplicationController

  def index
    
  end

  def create
    @friend = User.find_by(id: params[:friend_id])
    current_user.requested_friends << @friend
    redirect_back(fallback_location: root_url)
  end

  def update
    @friend = User.find_by(id: params[:id])
    accept_request(current_user, @friend)
  end

  def destroy
    @friend = User.find_by(id: params[:friend_id])
    current_user.friends.delete(@friend)
    @friend.friends.delete(current_user)
    redirect_back(fallback_location: root_url)
  end

end
