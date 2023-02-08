FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish[0, 15] }
    description { Faker::Food.description }
    association :user, factory: :user
  end
end
