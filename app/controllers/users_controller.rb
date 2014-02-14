class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:edit, :update, :index]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: [:destroy]

  def index
  	@users = User.paginate(:page => params[:page])
  end

  def show
  	#change to find by username index
  	@user = User.find(params[:id])
    #! Prevent page from being as if logged in after logging out and pressing "back". Implement at sitewide session level?
  end

  def new
  	@user = User.new
  	#! Don't allow users to go to login page via "back" when logged in.
  end

  def create
  	@user = User.new(user_params)	 
	  if @user.save
      log_in @user
      flash[:success] = "Welcome to My Character Types!"
	  	redirect_to @user
	  else
      #! why does this result in the url being user/ url?
      #! why does changing this to render 'edit' not work? cause
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
  	#! don't require password for updating normal fields.
    #! changing username, email, or password should require current password and confirmation.
    if @user.update(params[:user].permit(:username,:email,:password,:password_confirmation))
  		flash[:success] = "Profile updated."
      redirect_to @user
  	else
  		render 'edit'
  	end
  	#! require proper user session or admin
  end

  def destroy
  	@user = User.find(params[:id]).destroy
    flash[:success] = "User deleted."
  	redirect_to users_path
  	#! require proper user session or admin
  end

  private
    # whitelist form fields entered by users
    def user_params
  	  params.require(:user).permit(:username, 
                                   :email, 
                                   :password, 
                                   :password_confirmation)
    end

    def logged_in_user
      if !logged_in?
        store_location
        redirect_to login_url, notice: "Please log in." unless logged_in?
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless (current_user.admin == true)
    end

end
