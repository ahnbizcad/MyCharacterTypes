class SessionsController < ApplicationController

	def new
		#! Don't allow users to go to signup page via "back" when logged in.

		#@current_user
		#if logged_in?
		#	redirect_to user

	end

	def create
		#! Do this using email index
		user = User.find_by(email: params[:session][:email].downcase)
		correct_password = user.authenticate(params[:session][:password])
		if user && correct_password
			log_in user
			#! Redirect to page last viewed, not profile page.
			redirect_to user 
		else
			flash.now[:error] = 'Invalid email/password combination.'
			render 'new'
		end
		#@session = Session.new(session_params)
		#if  
		#else 
		#end
		
	end
	
	def destroy
		log_out
		#! Redirect to last viewed page
		redirect_to root_url

		#@session = Session.find(params[:id])
		#@session.destroy		
		#redirect_to home_path
	end

	#private 
	#
	#def session_params
	#	#! also allow username
	#	#! detect if username or email via presence of @ symbol, or non word characters
	#	@session.require(:session).permit(:email,:password)
	#end

end
