require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }

  describe "Login page" do
  	before { visit login_path }
  	
  	describe "should have title and header" do  		
    	it { shuould have_title(full_title('Log In')) }
    	it { should have_selector('h1', text: 'Log In') }    	
  	end

  	describe "with invalid information" do
  		before { click_button "Log In" }

  		describe "should have selector div.alert.alert-error" do
  			it { should have_selector('div.alert.alert-error') }
  			#it { should have_link('Log In', 	href: login_path(user)) }
  			it { should_not have_link('Log Out', 			href: logout_path(user)) }  			
  		end
  		describe "after visiting another page" do
  			before { click_link "Home" }
  			it { should_not have_selector('div.alert.alert-error') }
  		end
  	end

  	describe "with valid information" do
  		let(:user) { FactoryGirl.create(:user) }
  		before do
  			fill_in Email,			with: user.email.upcase
  			fill_in Password,	with: user.password
  			click_button "Log In" 
  		end
			  		
  		it { should have_link('Profile', 			href: user_path(user)) }
  		it { should have_link('Log Out', 			href: logout_path(user)) }
  		it { should_not have_link('Log In', 	href: login_path(user)) }

  	end

	end

end
