class UsersController < ApplicationController

  load_and_authorize_resource

  def index
    if !params[:search].nil?
      searched_user = User.search(params[:search])
      if searched_user.any?
        flash.now[:notice] = "#{searched_user.count} users found!"
        @users = searched_user.page(params[:page]).per(20)
      else
        flash.now[:alert] = "'#{params[:search]}' not found in Users"
        @users = User.page(params[:page]).per(20)
      end
    else
      @users = User.page(params[:page]).per(20)
    end
  end

  def show
  	@user=User.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).per(15)
    @friendship = Friendship.find_by(friend_id: @user.id, user_id: current_user.id)
  end
end
