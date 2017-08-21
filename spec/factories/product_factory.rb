FactoryGirl.define do
	
	sequence(:name) { |n| "product#{n}" }

	  factory :product do
	  name
    price 250
    description 'a bad hoodie'
    image_url 'http://jonvilma.com/images/cow-3.jpg'
    colour 'red'
  end

end