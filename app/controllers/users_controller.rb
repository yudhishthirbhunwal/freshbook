class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
  	@users=User.page(params[:page]).per(20)
  end

  def show
  	@user=User.find(params[:id])
  end
end
