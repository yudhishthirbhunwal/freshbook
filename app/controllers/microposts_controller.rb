class MicropostsController < ApplicationController
  
  load_and_authorize_resource
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:notice] = "Micropost created!"
      redirect_to root_url
    else
      flash.now[:alert] = "Could not create micropost!"
      @feed_items = current_user.feed.page(params[:page]).per(15)
      render 'static_pages/home'
    end
  end

  def edit
  end

  def update
    if @micropost.update(micropost_params)
      flash[:notice] = "Micropost updated!"
      redirect_to root_url
    else
      flash[:alert] = "Can't edit micropost!"
      redirect_back(fallback_location: root_url)
    end
  end

  def destroy
    @micropost.destroy
    flash[:alert] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
