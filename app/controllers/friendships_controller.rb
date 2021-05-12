class FriendshipsController < ApplicationController

  def friends
    if !params[:search].nil?
      searched_user = current_user.friends.search(params[:search])
      if searched_user.any?
        flash.now[:notice] = "#{searched_user.count} friends found!"
        @friends = searched_user.page(params[:page]).per(20)
      else
        flash.now[:alert] = "'#{params[:search]}' user not found in Friends"
        @friends = current_user.friends.page(params[:page]).per(20)
      end
    else
      @friends = current_user.friends.page(params[:page]).per(20)
    end
  end

  def create
    @friend = User.find_by(id: params[:friend_id])
    current_user.send_request(@friend)
    flash[:notice] = "Request Sent"
    redirect_back(fallback_location: root_url)
  end

  def update
    @friend = User.find_by(id: params[:id])
    if current_user.accept_request(@friend)
      flash[:notice] = "Request Accepted"
    end
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @friend = User.find_by(id: params[:id])
    current_user.unfriend(@friend)
    flash[:alert] = "Unfriended!!!"
    redirect_back(fallback_location: root_url)
  end

end
