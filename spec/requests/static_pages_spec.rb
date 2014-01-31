require 'spec_helper'

describe "Static pages -" do

	# Create variables in Rspec.
	# Define as symbol.
	# Use #{:variablename} to call.
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  subject { page }

  describe "Home page" do
  	before { visit home_path }

    it { should have_content('Sample App') }
    it { should have_title(full_title('Home')) }
  end

  describe "Help page" do
  	before {visit help_path }

    it { should have_content('Help') }
    it { should have_title("#{base_title} | Help") }
  end

  describe "About page" do
  	before {visit about_path }

    it { should have_content('About Us') }
    it { should have_title("#{base_title} | About Us") }
  end

  describe "Contact page" do
  	before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title("#{base_title} | Contact") }
  end

end