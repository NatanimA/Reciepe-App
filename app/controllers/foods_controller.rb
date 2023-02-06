class FoodsController < ApplicationController
  before_action :set_food, only: %i[show destroy]
  # before_action :authorize_delete, only: [:destroy]
  def index
    @foods = Food.where(user_id: current_user.id)
  end

  def create
    @user = current_user
    @food = @user.foods.build(food_params)
    if @food.valid?
      @food.save
      flash[:notice] = 'Food created successfully!'
      redirect_to new_user_food_path(@user, @food)
    else
      flash[:error] = @food.errors.full_messages.join(', ')
      render :new
    end
  end

  def new
    @food = Food.new
    @post.user = current_user
  end

  def destroy
    if @food.destroy
      redirect_to user_food_path(user_id: @food.user_id, id: @food.id), notice: 'Food was successfully deleted.'
    else
      redirect_to user_food_path(user_id: @food.user_id, id: @food.id), alert: 'Failed to delete food.'
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
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
