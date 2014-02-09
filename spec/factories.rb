FactoryGirl.define do

	# For user model object.
	factory :user do
		username "First_Last3Name"
		email "FirstLastName@ExamplE.CoM"
		password "foobar"
		password_confirmation "foobar"
	end	
	
end