# spec/models/food_spec.rb

require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user:, price: 10.0) }

  it 'has a valid factory' do
    sign_in user
    expect(food).to be_valid
  end

  it 'is invalid without a name' do
    sign_in user
    food.name = nil
    expect(food).not_to be_valid
  end

  it 'is invalid with a name length less than 3 characters' do
    sign_in user
    food.name = 'ab'
    expect(food).not_to be_valid
  end

  it 'is invalid with a name length more than 15 characters' do
    sign_in user
    food.name = 'a' * 16
    expect(food).not_to be_valid
  end

  it 'has many recipe_foods' do
    sign_in user
    FactoryBot.create(:recipe_food, food:)
    expect(food.recipe_foods.count).to eq(1)
  end

  it 'belongs to a user' do
    sign_in user
    expect(food.user).to eq(user)
  end

  it 'returns the correct name and quantity with measurement unit' do
    sign_in user
    expect(food.to_s).to eq("#{food.quantity} #{food.measurement_unit} of #{food.name}")
  end
end
