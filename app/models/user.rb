class User < ActiveRecord::Base
	require 'bcrypt'

	# Validations for name attribute.
	USERNAME_REGEX = /[\w]+/i 
	validates :username, 	presence: true, 
										uniqueness: { case_sensitive: false },
										length: { within: 4..20 },
										format: { with: USERNAME_REGEX }
										#disallow symbols by using regex
										#disallw space character

	# Validations for email attribute.
	before_save { email.downcase! }
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
										uniqueness: { case_sensitive: false },
										format: { with: EMAIL_REGEX }
										
	# Validations for password attribute, and securing password.
	# Takes care of password confirmation matching.
	has_secure_password 
	validates :password, presence: true,
											 length: { minimum: 6 }

	# Tokens
  before_create :create_remember_token

  def User.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
  	Digest::SHA1.hexdigest(token.to_s)
  end

  private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
  #use rescue to redirect away from exception error page when double clicking form rapidly
end
