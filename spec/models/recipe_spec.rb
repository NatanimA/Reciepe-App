require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) { FactoryBot.create(:recipe) }

  it 'has a valid factory' do
    expect(recipe).to be_valid
  end

  it 'is invalid without a name' do
    recipe = FactoryBot.build(:recipe, name: nil)
    expect(recipe).not_to be_valid
  end

  it 'is invalid without a description' do
    recipe = FactoryBot.build(:recipe, description: nil)
    expect(recipe).not_to be_valid
  end

  it 'is invalid with name length less than 3' do
    recipe = FactoryBot.build(:recipe, name: 'aa')
    expect(recipe).not_to be_valid
  end

  it 'is invalid with name length greater than 150' do
    recipe = FactoryBot.build(:recipe, name: 'a' * 155)
    expect(recipe).not_to be_valid
  end

  it 'is invalid with description length less than 3' do
    recipe = FactoryBot.build(:recipe, description: 'aa')
    expect(recipe).not_to be_valid
  end

  it 'is invalid with description length greater than 200' do
    recipe = FactoryBot.build(:recipe, description: 'a' * 201)
    expect(recipe).not_to be_valid
  end
  it 'has many recipe_foods' do
    FactoryBot.create(:recipe_food, recipe:)
    expect(recipe.recipe_foods.count).to eq(1)
  end

  # it "has many recipe_foods" do
  #   recipe.recipe_food.create
  #   expect(recipe.recipe_food.count).to eq(1)
  # end
end
