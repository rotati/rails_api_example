FactoryGirl.define do
  factory :property do
    name { Faker::Name.name }
    width 10
    length 10
    province { %w(kandal battambang krate kep kampot).sample.capitalize }
  end
end
