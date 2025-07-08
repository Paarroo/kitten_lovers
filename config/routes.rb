Rails.application.routes.draw do
  devise_for :users


  authenticate :user, ->(user) { user.admin? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end


  resources :users
  resources :items
  resource :cart, only: [:show]
  resources :cart_items
  resources :orders, only: [ :index, :show, :create ]
  resources :order_items, only: [ :show ]
  resources :purchased_items, only: [ :index ]


  # optionnal for Avo
  namespace :admin do
    resources :items
    resources :users
    resources :orders
  end

  # survey
  get "up" => "rails/health#show", as: :rails_health_check

  root "items#index"
end
