require 'spec_helper'

describe "USERS Table user -" do
	#before { user = User.new(username: "First_Last3Name",
	#													email: "FirstLastName@ExamplE.CoM",
	#													password: "foobar",
	#													password_confirmation: "foobar") }
	let(:user) { FactoryGirl.create(:user) }		
  subject { user }

	describe "Attributes should respond and be valid" do			
		#attributes
		it { should respond_to(:username) }
	  it { should respond_to(:email) }
	  it { should respond_to(:password_digest) }
	  it { should respond_to(:password) }
	  it { should respond_to(:password_confirmation) }
	  it { should respond_to(:remember_token) }
	  it { should respond_to(:admin) }
	  #it { should respond_to(:points)}
	  #methods
	  it { should respond_to(:authenticate) }
	  it { should be_valid }

  end

  describe "Username" do

  	describe "that's already taken, case insensitive" do
    	before { user_with_same_username = user.dup
  	  				 user_with_same_username.save }
  	  describe "should be invalid" do
  			it { should_not be_valid }
  		end
		end  	
  	describe "with less than 4 characters" do
	    before { user.username = "a" * (4-1) }
	    describe "should be invalid" do
    		it { should_not be_valid }
    	end
  	end
  	describe "with more than 25 characters" do
	    before { user.username = "a" * (25+1) }
	    describe "should be invalid" do
    		it { should_not be_valid }
    	end
  	end
  	describe "that's blank should" do
	  	before { user.username = " " }
	  	describe "should be invalid" do
    		it { should_not be_valid }
    	end
  	end
  	describe "that has only word characters (other than letters, numbers, underscore)" do
	  	before { user.username = "aA3_" }
	  	describe "should be valid" do
    		it { should be_valid }
    	end
  	end
  	describe "that has non-word characters" do
	  	before { user.username = "a1_ !" }
	  	describe "should be invalid" do
    		it { should_not be_valid }
    	end
  	end

	end

	describe "Email" do
  	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
		describe "that's blank should be invalid" do
	    before { user.email = " " }
   	  it { should_not be_valid }
  	end
  	describe "in a valid format should be valid" do
	  	addresses = %w[user@foo.COM.
  	 								A_US-ER@f.b.org.
  	  							frst.lst@foo.jp.
  	  			 				a+b@baz.cn]
  		addresses.each do |valid_address|
	  		before { user.email = valid_address }
  			it { should be_valid }
  		end
  	end
  	describe "in invalid format should be invalid" do
	  	addresses = %w[user@foo,com.
  									user_at_foo.org.
  	 								example.user@foo.
  	  							foo@bar_baz.com.
  	   							foo@bar+baz.com]
  		addresses.each do |invalid_address|
	  		before { user.email = invalid_address }
  			it { should_not be_valid }
  		end
  	end
  	#! syntax problem here
  	describe "that has mixed case" do
 			let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

 			it "should be saved as all lower-case" do
  			user.email = mixed_case_email
   			user.save
   			expect(user.reload.email).to eq mixed_case_email.downcase
 		  end
		end		
		describe "that's already taken, case insensitive" do
			before do
				user_with_same_email = user.dup 
				user_with_same_email.email = user.email.upcase
  			user_with_same_email.save
  		end
				it { should_not be_valid }
		end

	end		

	describe "Password" do 

		describe "that's blank should be invalid" do
			before { user.password = " "
						 	user.password_confirmation = " " }
			describe "should be invalid" do
				it { should_not be_valid }
			end
		end
		describe "that's shorter than 6 characters" do
			before { user.password = "12345"
							 user.password_confirmation = "12345" }
			describe "should be invalid" do
				it { should_not be_valid }
			end
		end
		describe "that doesn't match the password_confirmation" do
			before { user.password = "mismatch" }
			describe "should be invalid" do
				it { should_not be_valid }
			end
		end

	end

	describe "Authenticate method return Value" do

		before { user.save }
 		let(:found_user) { User.find_by(email: user.email) }
			
			describe "with valid password" do
 			it { should eq found_user.authenticate(user.password) }
		end
			describe "with invalid password" do
 			let(:user_for_invalid_password) { found_user.authenticate("invalid") }   			
  		it { should_not eq user_for_invalid_password }
  		specify { expect(user_for_invalid_password).to be_false }
		end

	end

	describe "Remember_token" do
		before { user.save }
		its(:remember_token) { should_not be_blank }

	end

	describe "with admin attribute set to true" do
		before do
			user.save!
			user.toggle!(:admin)
		end
		it { should be_admin }

	end

end
