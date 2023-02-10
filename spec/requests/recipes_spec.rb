require 'rails_helper'

RSpec.describe RecipesController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  before { login_as user }
  # before do
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  # end

  describe 'GET #index' do
    before do
      # create recipes for the current user
      FactoryBot.create_list(:recipe, 3, user:)
      # create recipes for other users
      FactoryBot.create_list(:recipe, 2)
    end

    it 'returns a success response' do
      get recipes_path
      expect(response).to be_successful
    end

    it 'returns the correct number of recipes' do
      get recipes_path
      expect(assigns(:recipes).count).to eq(3)
    end

    it 'returns only the recipes for the current user' do
      get recipes_path
      assigns(:recipes).each do |recipe|
        expect(recipe.user).to eq(user)
      end
    end
  end

  describe 'GET #public' do
    before do
      # create public recipes for the current user
      FactoryBot.create_list(:recipe, 2, user:, public: true)
      # create private recipes for the current user
      FactoryBot.create_list(:recipe, 3, user:, public: false)
      # create public recipes for other users
      FactoryBot.create_list(:recipe, 4, public: true)
    end

    it 'returns a success response' do
      get public_path
      expect(response).to be_successful
    end

    it 'returns only the public recipes for the current user' do
      get public_path
      assigns(:recipes).each do |recipe|
        expect(recipe.public).to be_truthy
      end
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_recipe_path
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:recipe) { FactoryBot.create(:recipe, user:) }

    it 'returns a success response' do
      get recipe_path(recipe)
      expect(response).to be_successful
    end

    it 'returns the correct recipe' do
      get recipe_path(recipe)
      expect(assigns(:recipe)).to eq(recipe)
    end
  end
  describe 'GET #shopping' do
    let(:recipe) { FactoryBot.create(:recipe) }

    it 'returns a success response' do
      get shoping_path(id: recipe.id)
      expect(response).to be_successful
    end
  end
end
