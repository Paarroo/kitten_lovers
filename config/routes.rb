Rails.application.routes.draw do
  # Authentication routes provided by Devise
  devise_for :users

  # User-friendly URL aliases
  get '/signup', to: redirect('/users/sign_up')
  get '/signin', to: redirect('/users/sign_in')
  get '/login', to: redirect('/users/sign_in')
  get '/users/sign_out', to: 'devise/sessions#destroy'

  # Admin panel access (admin users only) - Avo Engine
  authenticate :user, ->(user) { user.admin? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  # Public routes - accessible to everyone
  resources :items, only: [ :index, :show ] do
    collection do
      get :search
      get :featured
    end
  end

  # Static pages (public)
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  post '/contact', to: 'pages#create_contact'
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'

  # Authenticated user routes
  authenticate :user do
    resource :profile, controller: 'users', only: [ :show, :edit, :update ]
    get '/user', to: redirect('/profile')
    get '/account', to: redirect('/profile')

    resource :cart, only: [ :show, :update ] do
      resources :cart_items, only: [ :create, :update, :destroy ]
      member do
        delete :clear
        get :checkout
      end
    end
    #  Routes Stripe
    post "/checkout", to: "orders#checkout", as: :checkout
    get "/orders/success", to: "orders#success", as: :order_success
    get "/orders/cancel", to: "orders#cancel", as: :order_cancel

    resources :orders, only: [ :index, :show, :create ] do
      resources :order_items, only: [ :show ]
      member do
        get :invoice
        patch :cancel
      end
      collection do
        get :history
      end
    end


    resources :purchased_items, only: [ :index, :show ] do
      collection do
        get :recent
        get :downloads
      end
    end

    resources :wishlists, only: [ :index, :create, :destroy ]
    resources :notifications, only: [ :index, :show, :update ] do
      collection do
        patch :mark_all_read
      end
    end
  end

  # Admin routes for full CRUD operations
  authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      root 'dashboard#index'
      get 'dashboard', to: 'dashboard#index'
      get 'analytics', to: 'dashboard#analytics'
      get 'reports', to: 'dashboard#reports'

      resources :users do
        member do
          patch :toggle_admin
          patch :activate
          patch :deactivate
          patch :impersonate
        end
        collection do
          get :admins
          get :recent
          get :export
        end
      end

      resources :items do
        member do
          patch :toggle_featured
          patch :toggle_availability
          patch :duplicate
        end
        collection do
          get :featured
          get :out_of_stock
          get :low_stock
          get :export
          post :bulk_update
        end
      end

      resources :carts do
        resources :cart_items, except: [ :new, :edit ]
        member do
          delete :clear
          patch :convert_to_order
        end
        collection do
          get :abandoned
        end
      end

      resources :orders do
        member do
          patch :mark_as_paid
          patch :mark_as_shipped
          patch :mark_as_delivered
          patch :cancel
          patch :refund
          get :print
        end
        resources :order_items, except: [ :new, :edit ]
        collection do
          get :pending
          get :shipped
          get :completed
          get :cancelled
          get :export
          get :sales_report
        end
      end

      resources :purchased_items, only: [ :index, :show, :destroy ] do
        collection do
          get :by_user
          get :by_item
          get :recent
          get :analytics
          get :export
        end
      end

      get '/system', to: 'system#index'
      get '/system/cache', to: 'system#cache'
      delete '/system/cache', to: 'system#clear_cache'
      get '/system/logs', to: 'system#logs'
    end
  end

  # API routes (for future mobile app or integrations)
  namespace :api do
    namespace :v1 do
      resources :items, only: [ :index, :show ]
      authenticate :user do
        resource :profile, only: [ :show, :update ]
        resources :orders, only: [ :index, :show, :create ]
        resource :cart, only: [ :show, :update ] do
          resources :cart_items, only: [ :create, :update, :destroy ]
        end
      end
    end
  end

  # Error handling routes
  match '/404', to: 'errors#not_found', via: :all, as: :not_found
  match '/422', to: 'errors#unprocessable_entity', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # Health check and application root
  get "up" => "rails/health#show", as: :rails_health_check
  root "items#index"
end
