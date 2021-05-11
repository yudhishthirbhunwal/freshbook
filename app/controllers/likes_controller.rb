class LikesController < ApplicationController

  load_and_authorize_resource
  before_action :get_post

  def create
    if already_liked?
      flash[:alert] = "You can't like a post more than once."
    else
      @micropost.likes.create(user_id: current_user.id)
      # current_user.likes << @micropost.likes.create
    end
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @like = @micropost.likes.find_by(user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_url)
  end

  private

    def get_post
      @micropost = Micropost.find(params[:micropost_id])
    end

    def already_liked?
      Like.where(user_id: current_user.id, micropost_id: params[:micropost_id]).exists?
    end
end
