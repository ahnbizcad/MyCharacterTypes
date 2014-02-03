require 'spec_helper'

describe "USERS -" do

	describe "Table, subject @user -" do

		before { @user = User.new(name: "Example User", 
															email: "user@example.com",
															password: "foobar",
															password_confirmation: "foobar") }
	  subject { @user }


		describe "attributes should respond and be valid" do			
			#attributes
			it { should respond_to(:name) }
		  it { should respond_to(:email) }
		  it { should respond_to(:password_digest) }
		  it { should respond_to(:password) }
		  it { should respond_to(:password_confirmation) }

		  #methods
		  it { should response_to(:authenticate) }

		  it { should be_valid }

	  end
	  describe "Name" do

	  	describe "being blank should should be invalid" do
		  	before { @user.name = " " }
	    	it { should_not be_valid }
	  	end
	  	describe "name with more than 25 characters should be invalid" do
		    before { @user.name = "a" * (25+1) }
	    	it { should_not be_valid }
	  	end
	  	describe "name that's already taken should be invalid, case insensitive" do
	    	before { user_with_same_name = @user.dup
    	  	user_with_same_name.save }
	  		it { should_not be_valid }
			end  	

		end		
		describe "Email" do
	  	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
			describe "email that's blank should be invalid" do
		    before { @user.email = " " }
	   	  it { should_not be_valid }
	  	end
	  	describe " in a valid format should be valid" do
		  	addresses = %w[user@foo.COM.
	  	 								A_US-ER@f.b.org.
	  	  							frst.lst@foo.jp.
	  	  			 				a+b@baz.cn]
	  		addresses.each do |valid_address|
		  		before { @user.email = valid_address }
	  			it { should be_valid }
	  		end
	  	end
	  	describe "e in invalid format should be invalid" do
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
	  	describe "email that's already taken (case insensitive) should be invalid" do
	    	before { user_with_same_email = @user.dup
    	 		user_with_same_email.email.downcase!
    	  	user_with_same_email.save }
	  		it { should_not be_valid }
			end

		end
		describe "Password" do 

			describe "password that's blank should be invalid" do
				before { @user.password = " "
							 	@user.password_confirmation = " " }
				it { should_not be_valid }
			end
			describe "password that's shorter than 6 characters should be invalid" do
				before { @user.password = "qwert"
							 	@user.password_confirmation = "qwert" }
				it { should_not be_valid }
			end
			describe "password that doesn't match the password_confirmation should be invalid" do
				before { @user.password = "mismatch" }
				it { should_not be_valid }
			end

		end
		describe "Authenticate method return Value" do

 			before { @user.save }
	 		let(:found_user) { User.find_by(email: @user.email) }
 			
 			describe "with valid password" do
   			it { should eq found_user.authenticate(@user.password) }
			end
 			describe "with invalid password" do
   			let(:user_for_invalid_password) { found_user.authenticate("invalid") }   			
    		it { should_not eq user_for_invalid_password }
    		specify { expect(user_for_invalid_password).to be_false }
  		end

		end

	end

		###

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "PAGES, subject page -" do
  	before { visit signup_path }
  	subject { page }
	  
	  describe "Signup page" do
	    it { should have_selector('h1', text: 'Sign Up') }
	    it { should have_title(full_title('Sign Up')) }
	    #response.status.should be(200)
	  end
	end
	
end
