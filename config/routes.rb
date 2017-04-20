Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products

  resources :users, only: [:index, :show]
  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#logout'

  get 'products/:id/cart', to: 'order_items#create', as: 'cart'
end
