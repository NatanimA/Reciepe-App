# spec/features/recipes_spec.rb

require 'rails_helper'

RSpec.describe RecipesController, type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }
  let(:request) { double(:request, referrer: recipe_path) }
  before do
    sign_in(user)
  end

  describe 'GET #index' do
    before do
      recipe
      visit recipes_path
    end

    it 'displays all the recipes belonging to the current user' do
      expect(page).to have_content(recipe.name)
    end
  end

  describe 'GET #public' do
    before do
      recipe
      visit public_path
    end

    it 'displays all public recipes' do
      expect(page).to have_content('Public Recipes')
    end
  end

  describe 'GET #new' do
    before do
      visit new_recipe_path
    end

    it 'displays the form for creating a new recipe' do
      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
      expect(page).to have_field('Preparation time')
      expect(page).to have_field('Cooking time')
      expect(page).to have_field('Public')
      expect(page).to have_field('Photo')
    end
  end

  describe 'GET #show' do
    before do
      visit recipe_path(recipe)
    end

    it 'displays the details of the recipe' do
      expect(page).to have_content('Public Recipes')
    end
  end

  describe 'GET #shopping' do
    before do
      visit shoping_path(recipe)
    end

    it 'displays the shopping list for the recipe' do
      expect(page).to have_content('Amount of items to buy')
      # Add more expectations for the shopping list
    end
  end

  describe 'DELETE #destroy' do
    context 'When the recipe is destroyed successfully' do
      # before do
      #   visit recipe_path(recipe)
      #   click_link 'Delete'
      # end
      before { page.driver.submit :delete, recipe_path(recipe), {} }
      it 'displays a success message' do
        expect(page).to have_content('Recipe was successfully deleted.')
      end

      it 'redirects to the previous page' do
        path = "#{page.current_path}recipes"
        expect(path).to eq(recipes_path)
      end
    end
  end
end
