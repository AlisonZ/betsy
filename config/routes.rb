Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'products#index'
  resources :categories, :except => [:edit, :update, :destroy]
  resources :products
  resources :reviews, only: [:new, :create]

  resources :users, only: [:index, :show]
  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#logout'

  post 'products/:id/add', to: 'order_items#create', as: 'new_order_item'
  get '/cart', to: 'order_items#cart', as: 'cart'
end
