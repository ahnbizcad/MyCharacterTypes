def full_title(page_title)
	base_title = "My Character Types"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}"
	end
	
	def log_in(user, options={})
  	if options[:no_capybara]
    	# Sign in when not using Capybara.
    	remember_token = User.new_remember_token
    	cookies[:remember_token] = remember_token
    	user.update_attribute(:remember_token, User.encrypt(remember_token))
  	else
    	visit login_path
    	fill_in "Email",    with: user.email
   		fill_in "Password", with: user.password
    	click_button "Log In"
  	end
	end
end