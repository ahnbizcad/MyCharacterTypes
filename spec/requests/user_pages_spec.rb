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
  	before do 
  		log_in user
			visit edit_user_path(user) 
		end
    it { should have_selector('h1', text: 'Edit Profile') }
    it { should have_title(full_title('Edit Profile')) }   
    
    describe "with invalid information" do
			before { click_button "Save Changes" }
			it { should have_content('error') }
		end
		
		describe "with valid information" do
			let(:new_username)  { "NewName" }
			let(:new_email) { "new@example.com" }
			before do
				fill_in "Username", 				with: new_username
				fill_in "Email",						with: new_email
				fill_in "Password",					with: user.password
				fill_in "Confirm Password",	with: user.password_confirmation
				click_button "Save Changes"			   
			end
			it { should have_content('Profile') }
			it { should have_link('Log Out', href: logout_path) }
			it { should_not have_link('Log In', href: login_path) }
			specify { expect(user.reload.name).to eq new_username }
			specify { expect(user.reload.email).to eq new_email }
		end
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