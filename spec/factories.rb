FactoryGirl.define do

	# For user model object.
	factory :user do
		username "First Last Name"
		email "FirstLastName@ExamplE.CoM"
		password "foobar"
		password_confirmation "foobar"
	end	
	
end