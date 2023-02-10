FactoryBot.define do
  factory :food do
    name { Faker::Food.name[6, 15] }
    measurement_unit { %w[grams ml pieces].sample }
    quantity { Faker::Number.number(digits: 3) }
    price { Faker::Commerce.price(range: 1..4000) }
    user
  end
end
