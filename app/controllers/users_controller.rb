class UsersController < ApplicationController

  def index
  	@users = User.all
  end

  def show
  	#change to find by username index
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  	#disallow if logged, exception being admin
  end

  def create
  	@user = User.new(user_params)	 
	  if @user.save
	  	redirect_to @user #goes to show action - why?
	  else
	  	render 'new'
	  end
	  #disallow if logged, exception being admin
  end

  def edit
  	@user = User.find(params[:id])
  	#! require proper user session or admin
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(params[:user].permit(:name,:email))
  		redirect_to @user
  	else
  		render 'edit'
  	end
  	#! require proper user session or admin
  end

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy

  	redirect_to users_path
  	#! require proper user session or admin
  end

  private
  # whitelist form fields entered by users
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
