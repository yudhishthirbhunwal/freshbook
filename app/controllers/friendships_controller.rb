class FriendshipsController < ApplicationController

  def friends
    @friends = current_user.friends.page(params[:page]).per(20)
  end

  def create
    @friend = User.find_by(id: params[:friend_id])
    current_user.send_request(@friend)
    redirect_back(fallback_location: root_url)
  end

  def update
    @friend = User.find_by(id: params[:id])
    current_user.accept_request(@friend)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @friend = User.find_by(id: params[:friend_id])
    current_user.unfriend(@friend)
    redirect_back(fallback_location: root_url)
  end

end
