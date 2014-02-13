module SessionsHelper

	def log_out
		current_user.update_attribute(:remember_token, 
																	User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end	

	def log_in(the_user)
		# Create new token.
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		# Update_attribute bypasses validations.
		# Bypassing validations is necessary here a required password is absent in the inputs
		the_user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = the_user
	end

	def logged_in?
		!current_user.nil?
	end	

	def current_user
		# Local remember_token variable encrypts token value stored in cookie.
		remember_token = User.encrypt(cookies[:remember_token])
		# Find user whose remember_token attribute value matches the encrypted result of the token stored in the cookie.
		# Using ||= handles login as well as navigating pages during the session.
		# Doesn't hit database if value is already set - checks value before quering. Good!
		# ||= here uses short-circuit evaluation.
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def current_user=(the_user)
		@current_user = the_user
	end

	def current_user? (the_user)
		the_user == current_user
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end

	def redirect_back_or(default_page)
		redirect_to(session[:return_to] || default_page)
		session.delete(:return_to)
	end

end