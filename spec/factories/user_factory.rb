FactoryGirl.define do

  sequence(:email) { |n| "testuser#{n}@example.com"}
  
  factory :user do
    email
    password 'R$p3c!'
    first_name 'Gninja'
    last_name 'Panda'
    admin false
  end

  factory :admin, class: User do
    email
    password 'R$p3c!!'
    first_name 'masterninja'
    last_name 'BabyPanda'
    admin true
  end
    
end