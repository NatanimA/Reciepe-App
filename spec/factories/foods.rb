FactoryBot.define do
  factory :food do
    name { Faker::Food.dish[0, 15] }
    measurement_unit { %w[grams ml pieces].sample }
    quantity { Faker::Number.number(digits: 3) }
    user
  end
end
