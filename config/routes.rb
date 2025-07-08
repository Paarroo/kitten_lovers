Rails.application.routes.draw do
  devise_for :users

  authenticate :user, ->(user) { user.admin? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  resources :items, only: [ :index, :show ]

  authenticate :user do
    resource :profile  # look before to modif, maybe in conflic with devise

    resource :cart, only: [ :show, :update ] do
      resources :cart_items, only: [ :create, :update, :destroy ]
    end

    resources :orders, only: [ :index, :show, :create ] do
      resources :order_items, only: [ :show ]
    end

    resources :purchased_items, only: [ :index ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
  root "items#index"
end
