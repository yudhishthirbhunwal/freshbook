class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.page(params[:page]).per(15)
    end
  end

  def about
  end

  def contact
  end

  def help
  end
end
