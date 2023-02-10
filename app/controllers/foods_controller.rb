class FoodsController < ApplicationController
  load_and_authorize_resource
  before_action :set_food, only: %i[show destroy]
  def index
    @foods = Food.where(user_id: current_user.id)
  end

  def create(*recipe_id)
    @user = current_user
    recipe_id = params[:format]
    @food = Food.new(params.require(:new_food).permit(:name, :measurement_unit, :price, :quantity))
    @food.user = @user
    if @food.save
      flash[:notice] = 'Food created successfully!'
      if recipe_id.nil?
        redirect_to root_path
      else
        recipe_id = recipe_id.to_i
        @recipe = Recipe.find(recipe_id)
        @recipe_foods = RecipeFood.new(quantity: @food.quantity, food: @food, recipe: @recipe)
        if @recipe_foods.save
          flash[:notice] = 'Ingredient created successfully!'
        else
          flash[:alert] = @recipe_foods.errors.full_messages.join(', ')
        end
        redirect_to recipe_path(id: recipe_id)
      end
    else
      flash[:alert] = @food.errors.full_messages.join(', ')
      redirect_to new_food_path, locals: { food:@food }
    end
  end

  def new
    @food = Food.new
    @recipe_id = (params[:recipe_id] unless params[:recipe_id].nil?)
    respond_to do |format|
      format.html { render :new, locals: { food: @food } }
    end
  end

  def destroy
    if @food.destroy
      flash[:notice] = 'Food was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete food.'
    end
    respond_to do |format|
      format.html { redirect_to request.referrer }
    end
  end

  def show
    @food = Food.where(params[:user_id])
  end

  private

  def authorize_delete
    return if can? :delete, @food

    redirect_to user_food_path(user_id: @food.user_id, id: @food.id),
                notice: 'You are not authorized to delete this food.'
  end

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:new_food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
