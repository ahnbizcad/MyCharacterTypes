require 'spec_helper'

describe "USERS -" do

	describe "Table -" do
		before { @user = User.new(name: "Example User", email: "user@example.com") }
	  subject { @user }

		describe "should respond to attributes and be valid" do			
			it { should respond_to(:name) }
		  it { should respond_to(:email) }
		  it { should be_valid }
	  end	  

	  describe "name not present should be invalid" do
	  	before { @user.name = " " }
	    it { should_not be_valid }
	  end

	  describe "name should be 25 characters or less" do
	    before { @user.name = "a" * (25+1) }
	    it { should_not be_valid }
	  end

	  describe "email is not present should be invalid" do
	    before { @user.email = " " }
	    it { should_not be_valid }
	  end

	  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	  describe "when email is in a valid format" do
	  	addresses = %w[user@foo.COM.
	  	 							A_US-ER@f.b.org.
	  	  						frst.lst@foo.jp.
	  	  			 			a+b@baz.cn]
	  	addresses.each do |valid_address|
	  		before { @user.email = valid_address }
	  		it { should be_valid }
	  	end
	  end

	  describe "when email is in an invalid format" do
	  	addresses = %w[user@foo,com.
	  								user_at_foo.org.
	  	 							example.user@foo.
	  	  						foo@bar_baz.com.
	  	   						foo@bar+baz.com]
	  	addresses.each do |invalid_address|
	  		before { @user.email = invalid_address }
	  		it { should_not be_valid }
	  	end
	  end

	  describe "when email address is already taken" do
    	before { user_with_same_email = @user.dup
    	 	user_with_same_email.email.downcase!
    	  user_with_same_email.save }
	  	it { should_not be_valid }
		end

	end
	
	###

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "PAGES -" do
  	before { visit signup_path }
  	subject { page }
	  
	  describe "Signup page" do
	    it { should have_selector('h1', text: 'Sign Up') }
	    it { should have_title(full_title('Sign Up')) }
	    #response.status.should be(200)
	  end
	end
	
end
