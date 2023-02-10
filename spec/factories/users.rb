FactoryBot.define do
  factory :user do
    name { Faker::Name.name[0, 15] }
    email { Faker::Internet.email }
    password { 'password' }
    after(:build, &:skip_confirmation_notification!)
    after(:create, &:confirm)
  end
end
