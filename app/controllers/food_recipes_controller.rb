class FoodRecipesController < ApplicationController
    before_action :set_food_recipe, only: [:show, :destroy]
  
    def index
      @food_recipes = FoodRecipe.all
    end
  
    def new
      @food_recipe = FoodRecipe.new
    end
  
    def create
      @food_recipe = FoodRecipe.new(food_recipe_params)
  
      if @food_recipe.save
        redirect_to @food_recipe, notice: 'Food recipe was successfully created.'
      else
        render :new
      end
    end
    end
  
    def destroy
      @food_recipe.destroy
      redirect_to food_recipes_url, notice: 'Food recipe was successfully destroyed.'
    end
  
    private
      def set_food_recipe
        @food_recipe = FoodRecipe.find(params[:id])
      end
  
      def food_recipe_params
        params.require(:food_recipe).permit(:quantity)
      end
  end
  