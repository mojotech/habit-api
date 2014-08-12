FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    display_name { Faker::Name.name }
  end
end
