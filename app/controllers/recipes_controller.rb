class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[destroy]
  def index
    @recipes = Recipe.where(user_id: current_user.id).includes(:recipe_foods)
  end

  def public
    @recipes = Recipe.where(user_id: current_user.id, public: true).includes(:recipe_foods)
  end

  def new
    recipe = Recipe.new
    respond_to do |format|
      format.html { render :new, locals: { recipe: } }
    end
  end

  def show
    @recipe = Recipe.where(user_id: current_user.id, id: params[:id]).includes(:recipe_foods).first
  end

  def shoping
    @recipe = Recipe.where(id: params[:id]).includes(:recipe_foods).first
  end

  def destroy
    if @recipe.destroy
      redirect_to recipe_path(id: @recipe.id), notice: 'Food was successfully deleted.'
    else
      redirect_to recipe_path(id: @recipe.id), alert: 'Failed to delete food.'
    end
  end

  def create
    @user = current_user
    @recipe = Recipe.new(params.require(:new_recipe).permit(:name, :description, :preparation_time, :cooking_time, :public,
                                                            :photo))
    @recipe.user = @user
    if @recipe.save
      flash[:notice] = 'Recipe created successfully!'
      redirect_to recipes_path
    else
      flash[:error] = @recipe.errors.full_messages.join(', ')
      puts "Error is in:  #{flash[:error]}"
      recipe = Recipe.new
      respond_to do |format|
        format.html { redirect_to request.referrer, locals: { recipe: } }
      end
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :photo)
  end
end
