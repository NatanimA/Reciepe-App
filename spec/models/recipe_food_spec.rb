require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:recipe) { FactoryBot.create(:recipe) }
  let(:food) { FactoryBot.create(:food) }
  let(:recipe_food) { FactoryBot.create(:recipe_food, recipe:, food:) }

  it 'has a valid factory' do
    expect(recipe_food).to be_valid
  end

  it 'belongs to a recipe' do
    expect(recipe_food.recipe).to eq(recipe)
  end

  it 'belongs to a food' do
    expect(recipe_food.food).to eq(food)
  end
end
