RSpec.describe 'Foods', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user:) }

  before { login_as user }
  describe 'GET foods#index' do
    it 'returns a list of foods belonging to the current user' do
      FactoryBot.create(:food, user:)
      get root_path
      expect(response).to be_successful
    end
  end

  describe 'GET foods#new' do
    it 'renders the new food form' do
      get new_food_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /foods' do
    context 'with valid parameters' do
      it 'creates a new food and redirects to the show page' do
        post foods_path, params: { new_food: { name: 'Apple', measurement_unit: 'piece', price: 1.5, quantity: 10 } }

        expect(response).to redirect_to(root_path(Food.last))
        expect(flash[:notice]).to eq('Food created successfully!')
      end

      it 'creates a new ingredient for a recipe and redirects to the recipe show page' do
        recipe = FactoryBot.create(:recipe)

        post foods_path,
             params: { format: recipe.id, new_food: { name: 'Apple', measurement_unit: 'piece', price: 1.5, quantity: 10 } }

        expect(response).to redirect_to(recipe_path(recipe))
        expect(flash[:notice]).to eq('Ingredient created successfully!')
      end
    end

    context 'with missing new_food parameter' do
      it 'renders the new template and shows an error message' do
        post foods_path, params: { new_food: { name: '', measurement_unit: 'piece', price: 1.5, quantity: 10 } }

        expect(response).to redirect_to(new_food_path)
        expect(flash[:alert]).to eq("Name can't be blank, Name is too short (minimum is 3 characters)")
      end
      it 'redirects back and shows an error message' do
        post foods_path, params: { new_food: { name: 'Test food', measurement_unit: 'grams', price: '1.0', quantity: '100' } }

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
