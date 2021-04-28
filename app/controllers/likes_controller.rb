class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(like_params)
    @like.save
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
  end

  private

    def like_params
      params.require(:like).permit(:micropost_id, :comment_id)
    end
end
