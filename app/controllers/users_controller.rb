class UsersController < ApplicationController

  load_and_authorize_resource

  def index
  	@users=User.search(params[:search]).page(params[:page]).per(20)
  end

  def show
  	@user=User.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).per(15)
    @friendship = Friendship.find_by(friend_id: @user.id, user_id: current_user.id)
  end
end
