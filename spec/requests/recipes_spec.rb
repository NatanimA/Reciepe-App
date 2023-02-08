require 'rails_helper'

RSpec.describe RecipesController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }

  before do
    # user = FactoryBot.create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get user_recipes_path(user_id: user.id)
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_user_recipe_path(user)
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get user_recipe_path(user_id: user.id, id: recipe.id)
      expect(response).to be_successful
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested recipe' do
      expect { delete user_recipe_path(user_id: user.id, id: recipe.id) }.to change(Recipe, :count).by(-1)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new recipe' do
        expect do
          post user_recipes_path(user_id: user.id),
               params: { recipe: FactoryBot.attributes_for(:recipe) }
        end.to change(Recipe, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        post user_recipes_path(user_id: user.id), params: { recipe: { name: '' } }
        expect(response).to be_successful
      end
    end
  end
end
