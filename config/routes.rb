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
  devise_for :installs
  resources :users

  resources :cart_items
  resources :carts

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
