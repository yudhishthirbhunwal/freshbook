class LikesController < ApplicationController

  load_and_authorize_resource
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.likes << @micropost.likes.create
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @like = current_user.likes.find_by(micropost_id: params[:id])
    @like.destroy
    redirect_back(fallback_location: root_url)
  end

  # private

  #   def like_params
  #     params.require(:like).permit(:micropost_id)
  #   end
end
