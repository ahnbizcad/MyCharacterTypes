require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
	  it "should have the content 'Mostly Static'" do
	    # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
	    visit '/home'
	    expect(page).to have_content('Mostly Static')
	    #response.status.should be(200)
	  end
  end

  describe "Help page" do
  	it "should have the content 'Help'" do
	  	visit '/help'
	  	expect(page).to have_content('Help')
	  end
  end

  describe "About page" do
  	it "should have the content 'About'" do
  		visit '/about'
  		expect(page).to have_content('About')
  	end
  end

end
