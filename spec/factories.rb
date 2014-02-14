FactoryGirl.define do

	# For user model object.
	factory :user do
		username "First_Last3Name"
		email "FirstLastName@ExamplE.CoM"
		password "foobar"
		password_confirmation "foobar"
	end	
	
	#! causes approx 30 tests to fail.
	
  #factory :user do
  #  sequence(:name)  { |n| "Person_#{n}" }
  #  sequence(:email) { |n| "person_#{n}@g.c"}
  #  password "foobar"
  #  password_confirmation "foobar"
  #  
  #  factory :admin do
  #    admin true
  #  end
  #end

end