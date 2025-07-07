Rails.application.routes.draw do
  resources :admins
  devise_for :users
  resources :users
  resources :cart_items
  resources :carts
  resources :photos
  resources :orders
  resources :order_items

  get "up" => "rails/health#show", as: :rails_health_check

  # Route racine
  root "home#index"
end