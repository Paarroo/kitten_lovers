Rails.application.routes.draw do
  # Authentication routes provided by Devise
  devise_for :users

  # URL aliases for easier access (redirect to proper Devise routes)
  get '/users/signup', to: redirect('/users/sign_up')
  get '/users/signin', to: redirect('/users/sign_in')
  get '/users/signout', to: redirect('/users/sign_out')

  # Additional user-friendly aliases
  get '/signup', to: redirect('/users/sign_up')
  get '/signin', to: redirect('/users/sign_in')
  get '/login', to: redirect('/users/sign_in')
  get '/logout', to: redirect('/users/sign_out')

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
    # User profile management
    resource :profile, controller: 'users', only: [ :show, :edit, :update ]

    # Alternative route for user profile
    get '/user', to: redirect('/profile')
    get '/account', to: redirect('/profile')

    # Shopping cart functionality
    resource :cart, only: [ :show, :update ] do
      resources :cart_items, only: [ :create, :update, :destroy ]
      member do
        delete :clear
        get :checkout
      end
    end

    # Order management
    resources :orders, only: [ :index, :show, :create ] do
      resources :order_items, only: [ :show ]
      member do
        get :invoice
        patch :cancel
      end
      collection do
        get :history               # Order history
      end
    end

    # User's purchase history
    resources :purchased_items, only: [ :index, :show ] do
      collection do
        get :recent
        get :downloads             # Digital downloads if applicable
      end
    end

    # Wishlist functionality (if needed later)
    resources :wishlists, only: [ :index, :create, :destroy ]

    # User notifications
    resources :notifications, only: [ :index, :show, :update ] do
      collection do
        patch :mark_all_read
      end
    end
  end

  # Admin routes for full CRUD operations
  authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      # Admin dashboard
      root 'dashboard#index'
      get 'dashboard', to: 'dashboard#index'
      get 'analytics', to: 'dashboard#analytics'
      get 'reports', to: 'dashboard#reports'

      # User management with admin actions
      resources :users do
        member do
          patch :toggle_admin
          patch :activate
          patch :deactivate
          patch :impersonate       # Impersonate user (admin feature)
        end
        collection do
          get :admins              # List admin users
          get :recent              # Recently registered users
          get :export              # Export users data
        end
      end

      # Item management with enhanced features
      resources :items do
        member do
          patch :toggle_featured     # Mark as featured item
          patch :toggle_availability # Toggle availability status
          patch :duplicate           # Duplicate item
        end
        collection do
          get :featured
          get :out_of_stock         # List unavailable items
          get :low_stock            # Items with low inventory
          get :export               # Export items data
          post :bulk_update         # Bulk operations
        end
      end

      # Cart management (view and modify user carts)
      resources :carts do
        resources :cart_items, except: [ :new, :edit ]
        member do
          delete :clear             # Clear entire cart
          patch :convert_to_order   # Convert abandoned cart to order
        end
        collection do
          get :abandoned            # Show abandoned carts
        end
      end

      # Order management with comprehensive status updates
      resources :orders do
        member do
          patch :mark_as_paid
          patch :mark_as_shipped
          patch :mark_as_delivered
          patch :cancel
          patch :refund
          get :print                # Print order details
        end
        resources :order_items, except: [ :new, :edit ]
        collection do
          get :pending
          get :shipped
          get :completed
          get :cancelled
          get :export               # Export orders data
          get :sales_report         # Sales analytics
        end
      end

      # Purchase history management
      resources :purchased_items, only: [ :index, :show, :destroy ] do
        collection do
          get :by_user              # Filter by user
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
      # Public API endpoints
      resources :items, only: [ :index, :show ]

      # Authenticated API endpoints
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

  # Application root
  root "items#index"

  # Catch-all route for SPA-style routing (if needed)
  # get '*path', to: 'application#not_found', constraints: lambda { |req|
  #   !req.xhr? && req.format.html?
  # }
end
