class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show destroy]
  def index
    @recipes = Recipe.where(user_id: params[:user_id]).includes(:user)
  end

  def new
    @recipe = Recipe.new
    @recipe.user = current_user
  end

  def show
    @recipe = Recipe.where(user_id: params[:user_id], id: params[:id]).includes(:food)
  end

  def destroy
    if @recipe.destroy
      redirect_to user_recipe_path(user_id: @recipe.user_id, id: @recipe.id), notice: 'Food was successfully deleted.'
    else
      redirect_to user_recipe_path(user_id: @recipe.user_id, id: @recipe.id), alert: 'Failed to delete food.'
    end
  end

  def create
    @user = current_user
    @recipe = @user.recipes.build(recipe_params)
    if @recipe.valid?
      @recipe.save

      flash[:notice] = 'Recipe created successfully!'
      redirect_to new_user_recipe_path(@user, @recipe)
    else
      flash[:error] = @recipe.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
