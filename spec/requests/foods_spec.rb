RSpec.describe 'Foods', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user:) }

  before do
    # user = FactoryBot.create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe 'GET foods#index' do
    it 'returns a list of foods belonging to the current user' do
      food = FactoryBot.create(:food, user:)
      get root_path
      expect(assigns(:foods)).to include(food)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET foods#new' do
    it 'renders the new food form' do
      # food = FactoryBot.create(:food, user:)
      get new_user_food_path(user.id)
      expect(assigns(:food)).to be_a_new(Food)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POSt foods#create' do
    context 'with valid parameters' do
      it 'creates a new food and redirects to the show page' do
        post user_foods_path(user.id), params: { food: FactoryBot.attributes_for(:food) }
        expect(assigns(:food)).to be_persisted
        expect(flash[:notice]).to eq('Food created successfully!')
        expect(response).to redirect_to(new_user_food_path(user, Food.last))
      end
    end

    # context 'with invalid parameters' do
    #   it 'renders the new form with an error message' do
    #     get new_user_food_path(user.id), params: { food: { name: nil, measurement_unit: 'kg', price: 1.5, quantity: 2 } }
    #     expect(assigns(:food)).to be_a_new(Food)
    #     expect(flash[:error]).to include("Name can't be blank")
    #     expect(response).to render_template(:new)
    #   end
    # end
  end

  describe 'DELETE /foods/:id' do
    it 'deletes the specified food and redirects to the show page with a notice' do
      delete user_food_path(user.id, food.id)
      expect(Food.count).to eq(0)
      expect(flash[:notice]).to eq('Food was successfully deleted.')
      expect(response).to redirect_to(user_food_path(user_id: food.user_id, id: food.id))
    end
  end
end
