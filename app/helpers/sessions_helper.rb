module SessionsHelper

def log_in(the_user)
	# Create new token.
	remember_token = User.new_remember_token
	# Save new token into permanent cookie.
	cookies.permanent[:remember_token] = remember_token
	# encrypt and update the new token into the database for the user record.
	user.update_attribute(:remember_token, User.encrypt(remember_token))
	# Set the session's user to the user (who will log in successfully).
	# Unnec to set this because the create action immediately redirects using the user
	self.current_user = the_user
end
