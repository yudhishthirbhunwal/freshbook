class CommentsController < ApplicationController

  load_and_authorize_resource
  before_action :get_post

  def new
    @comment = Comment.new
  end

  def create
    @comment = @micropost.comments.build(comment_params)
    # @comment.micropost_id = @micropost.id
    @comment.user_id = current_user.id
    @comment.image.attach(params[:comment][:image])
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.update(comment_params)
      flash[:success] = "Comment updated!"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :image)
    end

    def get_post
      @micropost = Micropost.find_by(id: params[:micropost_id])
    end
end
