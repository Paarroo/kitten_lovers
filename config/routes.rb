Rails.application.routes.draw do
  get "pages/about"
  get "pages/contact"
  get "home/index"
  namespace :admin do
    resources :categories
    resources :products
    resources :user_managements
    resources :managements
  end
  namespace :user do
    get "dashboard/index"
    resources :orders
    resources :profiles
  end
  devise_for :users
  devise_for :admins
  resources :orders
  resources :admins
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