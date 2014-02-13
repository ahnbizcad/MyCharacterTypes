class SessionsController < ApplicationController

	def new
		redirect_to user_path(current_user) if logged_in?
		#@session = Session.new
		#@user ||= User.find_by(email: params[:session][:email])
		#! Don't allow users to go to signup page via "back" when logged in.
		#! Nevermind It's fine. Session will be replaced, not two-at-once.
	end

	def create
		#! Do this using email index
		user = User.find_by(email: params[:session][:email].downcase)
		correct_password = user.authenticate(params[:session][:password]) unless user.nil?
		if user && correct_password
			log_in user
			redirect_back_or user 
		else
			flash.now[:error] = 'Invalid email/password combination.'			
			render '/sessions/new'
		end
		#@session = Session.new(session_params)
		#if  
		#else 
		#end
		
	end
	
	def destroy
		log_out
		#! Redirect to last viewed page
		store_location
		redirect_back_or root_url
	end

	#private 
	#
	#def session_params
	#	#! also allow username
	#	#! detect if username or email via presence of @ symbol, or non word characters
	#	@session.require(:session).permit(:email,:password)
	#end

end
