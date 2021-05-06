class LikesController < ApplicationController

  load_and_authorize_resource
  before_action :get_post

  def create
    current_user.likes << @micropost.likes.create
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
end
