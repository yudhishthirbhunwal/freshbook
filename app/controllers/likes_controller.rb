class LikesController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.likes << @micropost.likes.create
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @like = current_user.likes.find(params[:micropost_id])
    @like.destroy
  end

  # private

  #   def like_params
  #     params.require(:like).permit(:micropost_id)
  #   end
end
