FactoryGirl.define do
  factory :habit do
    title { Faker::Lorem.sentence }
    unit { Faker::Lorem.word }
  end
end
