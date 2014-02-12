require 'spec_helper'

describe "USERS Pages page -" do
	let(:user) { FactoryGirl.create(:user) }	
	let(:base_title) { "Ruby on Rails Tutorial Sample App" }
	subject { page }
  
  describe "Index page" do
  	before { visit users_path }
    it { should have_selector('h1', text: 'Users') }
    it { should have_title(full_title('Users')) }
  end

  describe "Show page" do
  	before { user.save
  					 visit user_path(user) }
    it { should have_selector('h1', text: 'Profile') }
    it { should have_title(full_title('Profile')) }
  end

  describe "Edit page" do
  	before { user.save
  					 visit edit_user_path(user) }
    it { should have_selector('h1', text: 'Edit Profile') }
    it { should have_title(full_title('Edit Profile')) }
  end	  

  describe "Signup page" do
		before { visit signup_path }

		it { should have_selector('h1', text: 'Create Account') }
    it { should have_title(full_title('Create Account')) }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button "Create Account" }.not_to change(User, :count)
			end
		end

    describe "with valid information" do
			before do 
				fill_in "Username",								with: "Example User"
				fill_in "Email",									with: "UsEr@GmAiL.cOm"
				fill_in "Password",								with: "foobar"
				fill_in "Confirm Password",	with: "foobar"
			end

			it "should create a user" do
				expect { click_button "Create Account" }.to change(User, :count).by(1)
			end

		end
  end

  

end