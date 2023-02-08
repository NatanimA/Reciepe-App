FactoryBot.define do
  factory :user do
    name { Faker::Name.name[0, 15] }
  end
end
