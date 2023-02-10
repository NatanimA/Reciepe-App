Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
end
  root 'foods#index'
  resources :foods, only: [:index,:new,:create,:destroy]
  resources :recipes, only: [:index, :show,:new,:create,:destroy] do
    resources :foods, only: [:new]
  end
  get '/public_recipes/', to: "recipes#public", as: "public"
  get '/general_shoping_list/:id', to: "recipes#shoping", as: "shoping"

end
