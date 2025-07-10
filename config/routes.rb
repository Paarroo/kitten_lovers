Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  get '/signup', to: redirect('/users/sign_up')
  get '/signin', to: redirect('/users/sign_in')
  get '/login', to: redirect('/users/sign_in')
  get '/logout', to: 'users#sign_out'
  delete '/logout', to: 'users#sign_out'

  authenticate :user, ->(user) { user.admin? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  resources :items, only: [ :index, :show ]
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  post '/contact', to: 'pages#create_contact'
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'

  authenticate :user do
    get '/profile', to: 'users#show', as: :profile
    get '/profile/edit', to: 'users#edit', as: :edit_profile
    patch '/profile', to: 'users#update'
    delete '/profile', to: 'users#delete_account', as: :delete_account

    resource :cart, only: [ :show, :update ] do
      resources :cart_items, only: [ :create, :update, :destroy ]
      member do
        delete :clear
      end
    end

    post "/checkout", to: "orders#checkout", as: :checkout
    get "/orders/success", to: "orders#success", as: :order_success
    get "/orders/cancel", to: "orders#cancel", as: :order_cancel
    resources :orders, only: [ :index, :show, :create ] do
      resources :order_items, only: [ :show ]
      member do
        patch :cancel
      end
    end
    resources :purchased_items, only: [ :index, :show, :create ]
  end

  authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      root 'dashboard#index'
      resources :users do
        member do
          patch :toggle_admin
        end
      end
      resources :items
      resources :carts
      resources :orders
      resources :purchased_items, only: [ :index, :show, :destroy ]
    end
  end

  match '/404', to: 'errors#not_found', via: :all, as: :not_found
  match '/422', to: 'errors#unprocessable_entity', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  get "up" => "rails/health#show", as: :rails_health_check

  root "items#index"
end
