FactoryGirl.define do
  factory :habit do
    title { Faker::Lorem.sentence }
  end
end
