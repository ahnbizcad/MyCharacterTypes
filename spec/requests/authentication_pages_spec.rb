require 'spec_helper'

describe "Authentication -" do
  subject { page }

  describe "Login page -" do
  	before { visit login_path }
  	
  	describe "should have title and header" do  		
    	it { should have_title(full_title('Log In')) }
    	it { should have_selector('h1', text: 'Log In') }    	
  	end

  	describe "with invalid information" do
  		before { click_button "Log In" }
  		describe "should have selector div.alert.alert-error" do
  			it { shuould have_title(full_title('Log In')) }
  			it { should have_selector('div.alert.alert-error') }
  			it { should have_link('Log In', 			href: login_path) }
  			it { should_not have_link('Log Out', 	href: logout_path) }  			
  		end
  		describe "after visiting another page" do
  			before { click_link "Home" }
  			it { should_not have_selector('div.alert.alert-error') }
  		end
  	end

  	describe "with valid information" do
  		let(:user) { FactoryGirl.create(:user) }
  		before { user.save
  						 fill_in "Email",			with: user.email.upcase
  						 fill_in "Password",	with: user.password
  						 click_button "Log In" }	

  		describe "after saving the user" do	
  			it { should have_link(user.username, 	href: user_path(user)) }
  			it { should have_link('Log Out', 			href: logout_path(user)) }
  			it { should_not have_link('Log In', 	href: login_path(user)) }
			end

			describe "followed by logout" do
				before { click_link "Log Out" }
				it { should have_link('Log In') }
			end

  	end
	end

	describe "Authorize -" do
		let(:user) { FactoryGirl.create(:user) }

		describe "in the Users Controller" do

			describe "as a non logged in user" do

				describe "visiting the edit user page" do
					before { visit edit_user_path(user) }
					it { should have_title('Log In') }
				end

				describe "submitting to the update action" do
					before { patch user_path(user) }
					specify { expect(response).to redirect_to(login_path) }
				end

				describe "submitting to the destroy action" do
					before { user.save
									 delete user_path(user) }
					specify { expect(response).to redirect_to(login_path) }
				end	

				#
				describe "visiting a protected page" do
       		before do
        	  visit edit_user_path(user)
        		fill_in "Email",    with: user.email
          	fill_in "Password", with: user.password
						user.save
						click_button "Log In"          
       		end
        		describe "after signing in" do
          	it "should render the desired protected page" do
            	expect(page).to have_title('Edit Profile')
          	end
        	end	
      	end

      	describe "visiting users index page" do
      		before { visit users_path }
      		it { should have_title('Log In') }
      	end
			end

			describe "as wrong user" do
				let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
				before { log_in wrong_user, use_capybara: false }

				describe "submitting a GET request to Users#edit action" do
					before  { get edit_user_path(user) }
					specify { expect(response.body).not_to match(full_title('Edit Profile')) }
					specify { expect(response).to redirect_to(user_path(user)) }
				end

				describe "submitting a PATCH request to Users#update action" do
					before { PATCH user_path(user) }
					specify { expect(response).to redirect_to(user_path(user)) }
				end

			end

			#describe "as your own non-admin user" do
			#	describe "visiting edit profile page of that user" do
			#		visit { edit_user_path(user) }
			#	end					
			#end


		end


	end
end
