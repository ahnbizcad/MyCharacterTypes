class UsersController < ApplicationController

  def index
  	@users = User.all
  end

  def show
  	#@user = 
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  end

  def update
  	@user = User.find(params[:id])
  end

  def destroy
  	@user = User.find(params[:id])
  end

  private

  

  # whitelist form fields entered by users
  def user_params
  	params.require(:user).permit(:name, :email)
  end
end
