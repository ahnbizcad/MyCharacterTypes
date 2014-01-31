require 'spec_helper'

describe "UserPages -" do

	subject { page }
	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Signup Page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_title( full_title('Sign Up') ) }
    #response.status.should be(200)
  end

end
