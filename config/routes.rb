Rails.application.routes.draw do
 devise_for :users

 # avo_admin
 authenticate :user, ->(user) { user.admin? } do
   mount Avo::Engine, at: Avo.configuration.root_path
 end

 resources :items, only: [ :index, :show ]

 authenticate :user do
   resource :profile, controller: 'users', only: [ :show, :edit, :update ]

   resources :carts, only: [ :show, :update ]
   resources :cart_items, only: [ :create, :update, :destroy ]
   resources :orders, only: [ :index, :show, :create ]
   resources :order_items, only: [ :show ]
   resources :purchased_items, only: [ :index ]
 end

 get "up" => "rails/health#show", as: :rails_health_check

 root "items#index"
end
