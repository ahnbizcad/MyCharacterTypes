class UsersController < ApplicationController

  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)	 
	  if @user.save
	  	redirect_to @user
	  else
	  	render 'new'
	  end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(params[:user].permit(:name,:email))
  		redirect_to @user
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy

  	redirect_to users_path
  end

  private
  # whitelist form fields entered by users
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
