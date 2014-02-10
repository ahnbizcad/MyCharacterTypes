class SessionsController < ApplicationController

	def new
		
	end

	def create
		#! Do this using email index
		user = User.find_by(email: params[:session][:email].downcase)
		correct_password = user.authenticate(params[:session][:password])
		if user && correct_password
			log_in user
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
		@session = Session.find(params[:id])
	end

	private 

	def session_params
		#! also allow username
		#! detect if username or email via presence of @ symbol, or non word characters
		@session.require(:session).permit(:email,:password)
	end


end
