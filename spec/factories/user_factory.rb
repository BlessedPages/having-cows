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
    firstname 'masterninja'
    lastname 'BabyPanda'
    admin true
  end
end