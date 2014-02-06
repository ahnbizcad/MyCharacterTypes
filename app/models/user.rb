class User < ActiveRecord::Base
	require 'bcrypt'

	# Validations for name attribute.
	validates :name, 	presence: true, 
										uniqueness: { case_sensitive: false },
										length: { minimum: 4 },
										length: { maximum: 25 }
										#disallow symbols by using regex

	# Validations for email attribute.
	before_save { email.downcase! }
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
										uniqueness: { case_sensitive: false },
										format: { with: EMAIL_REGEX }
										
	# Validations for password attribute, and securing password.
	has_secure_password #takes care of password confirmation matching
	validates :password, presence: true,
											 length: { minimum: 6 }

end
