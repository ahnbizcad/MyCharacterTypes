require 'spec_helper'

describe "USERS Pages page -" do

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }
	subject { page }
  
  describe "Index page" do
  	before { visit users_path }
    it { should have_selector('h1', text: 'Users') }
    it { should have_title(full_title('Users')) }
  end

  describe "Show page" do
  	before { visit user_path(user) }
    it { should have_selector('h1', text: 'Profile') }
    it { should have_title(full_title('Profile')) }
  end

  describe "Signup page" do
		before { visit signup_path }
		let(:submit) { "Create my account" }

		it { should have_selector('h1', text: 'Sign Up') }
    it { should have_title(full_title('Sign Up')) }
		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end
    describe "with valid information" do
			before do 
				fill_in "Username",			with: "Example User"
				fill_in "Email",				with: "UsEr@GmAiL.cOm"
				fill_in "Password",			with: "foobar"
				fill_in "Confirm",			with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
  end

  describe "Edit page" do
  	before { visit edit_user_path }
    it { should have_selector('h1', text: 'Edit Profile') }
    it { should have_title(full_title('Edit Profile')) }
  end	  

end