Rails.application.routes.draw do
  root 'users#index'  
  resources :users, only: [:index, :show] do
    resources :foods, only: [:index, :show, :new, :create, :destroy] do
      resources :recipes, only: [:index, :create, :destroy] 
      resources :food_recipes, only: [:create, :destroy, :new]
    end
  end
end
