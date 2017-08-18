FactoryGirl.define do
	
	  factory :comment do
	  	user
	  	product
	  	body "FactoryGirl Comment"
	  	rating 5
  end
end