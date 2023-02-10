require 'rails_helper'

RSpec.describe FoodsController, type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user:) }
  let(:request) { double(:request, referrer: foods_path) }
  before(:each) do
    sign_in user
  end

  describe '#index' do
    it 'lists the foods created by the current user' do
      food
      visit foods_path

      expect(page).to have_content food.name
    end
  end

  describe '#create' do
    context 'when creating a food without a recipe_id' do
      it 'creates a food successfully' do
        visit new_food_path
        fill_in 'Name', with: 'Apple'
        fill_in 'Measurement unit', with: 'kg'
        fill_in 'Price', with: 2.5
        fill_in 'Quantity', with: 1
        click_button 'Add Food'

        expect(page).to have_content 'Food created successfully!'
      end

      it 'displays errors if the food creation fails' do
        visit new_food_path
        fill_in 'Name', with: ''
        fill_in 'Measurement unit', with: 'kg'
        fill_in 'Price', with: 2.5
        fill_in 'Quantity', with: 1
        click_button 'Add Food'

        expect(page).to have_content "Name can't be blank"
      end
    end

    context 'when creating a food with a recipe_id' do
      let(:recipe) { FactoryBot.create(:recipe, user:) }

      it 'creates a food and a recipe food successfully' do
        visit new_food_path(recipe_id: recipe.id)
        fill_in 'Name', with: 'Apple'
        fill_in 'Measurement unit', with: 'kg'
        fill_in 'Price', with: 2.5
        fill_in 'Quantity', with: 1
        click_button 'Add Food'

        expect(page).to have_content 'Ingredient created successfully!'
      end

      it 'displays errors if the food creation or recipe food creation fails' do
        visit new_food_path(recipe_id: recipe.id)
        fill_in 'Name', with: ''
        fill_in 'Measurement unit', with: 'kg'
        fill_in 'Price', with: 2.5
        fill_in 'Quantity', with: 1
        click_button 'Add Food'

        expect(page).to have_content "Name can't be blank"
      end
    end
  end

  describe '#new' do
    it 'renders the new food form' do
      visit new_food_path

      expect(page).to have_field 'Name'
      expect(page).to have_field 'Measurement unit'
      expect(page).to have_field 'Price'
      expect(page).to have_field 'Quantity'
    end
  end
  describe 'DELETE #destroy' do
    context 'when food is destroyed successfully' do
      # let(:request) { double(:request, referrer: foods_path) }

      before { page.driver.submit :delete, food_path(food), {} }

      it 'displays a success message' do
        expect(page).to have_content 'Food was successfully deleted.'
      end

      it 'redirects back to the previous page' do
        path = "#{page.current_path}foods"
        expect(path).to eq request.referrer
      end
    end

    context 'when food deletion fails' do
      before do
        allow(food).to receive(:destroy).and_return(false)
        page.driver.submit :delete, food_path(food), {}
      end

      # it 'displays an error message' do
      #   expect(page).to have_content('Failed to delete food.')
      # end

      it 'redirects back to the previous page' do
        path = "#{page.current_path}foods"
        expect(path).to eq request.referrer
      end
    end
  end

  describe 'GET #show' do
    before { visit root_path(food) }

    it 'displays the food details' do
      expect(page).to have_content food.name
      expect(page).to have_content food.measurement_unit
      expect(page).to have_content food.price
      expect(page).to have_content food.quantity
    end
  end
end
