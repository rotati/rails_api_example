FactoryGirl.define do
  factory :property do
    name { Faker::Name.name }
    width 10
    length 10
    province { Faker::Lorem.word }
  end
end
