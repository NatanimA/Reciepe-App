class RecipesController < ApplicationController
  load_and_authorize_resource
  before_action :set_recipe, only: %i[destroy]

  def index
    @recipes = Recipe.where(user_id: current_user.id).includes(:recipe_foods)
  end

  def public
    @recipes = Recipe.where(public: true).includes(:recipe_foods)
  end

  def new
    recipe = Recipe.new
    respond_to do |format|
      format.html { render :new, locals: { recipe: } }
    end
  end

  def show
    @recipe = Recipe.where(id: params[:id]).includes(:recipe_foods).first
  end

  def shoping
    @recipe = Recipe.where(id: params[:id]).includes(:recipe_foods).first
  end

  def destroy
    if @recipe.destroy
      flash[:notice] = 'Recipe was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete Recipe.'
    end
    respond_to do |format|
      format.html { redirect_to request.referrer }
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
      flash[:alert] = @recipe.errors.full_messages.join(', ')
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
    params.require(:new_recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :photo)
  end
end
