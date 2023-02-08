Rails.application.routes.draw do
  root 'foods#index'  
  resources :users, only: [:index, :show] do
    resources :foods, only: [:index, :show, :new, :create, :destroy] do
      resources :recipe_foods, only: [:index, :create, :destroy, :new]
    end
    resources :recipes, only: [:index, :create, :destroy] do
      resources :recipe_foods, only: [:index, :create, :destroy, :new]
    end
  end
end