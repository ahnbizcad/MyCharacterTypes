class User < ActiveRecord::Base

	validates :name, 	presence: true, 
										uniqueness: { case_sensitive: false },
										length: { maximum: 25 }

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
										uniqueness: { case_sensitive: false },
										format: { with: EMAIL_REGEX }
										
	has_secure_password
	validates :password, presence: true,
											 length: { minimum: 6 }

	#has_secure_password 

end
