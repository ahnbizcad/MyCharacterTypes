module SessionsHelper

	def log_in(the_user)
		# Create new token.
		remember_token = User.new_remember_token
		# Save new token into permanent cookie.
		# Cookie is created now.
		cookies.permanent[:remember_token] = remember_token
		# Update the remember_token attribute in the User database after encrypting it.
		# Update_attribute bypasses validations.
		# Bypassing validations is necessary here because a password was required, and we have no password here(?).
		the_user.update_attribute(:remember_token, User.encrypt(remember_token))
		# Set the session's user to the user (who will log in successfully).
		# Unnec to set this because the create action immediately redirects using the user
		self.current_user = the_user
	end

	def logged_in?
		!current_user.nil?
	end
	
	def current_user=(the_user)
		@current_user = the_user
	end
	def current_user
		# Local remember_token variable encrypts token value stored in cookie.
		remember_token = User.encrypt(cookies[:remember_token])
		# Find user whose remember_token attribute value matches the encrypted result of the token stored in the cookie.
		# Using ||= handles login as well as navigating pages during the session.
		# Doesn't hit database if value is already set - checks value before quering. Good!
		# Uses short-circuit evaluation.
		@current_user ||= User.find_by(remember_token: remember_token)
	end

end