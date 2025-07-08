Rails.application.routes.draw do
  devise_for :users
  authenticate :user, ->(user) { user.admin? } do
     namespace :admin do
       root 'dashboard#index'
       get 'dashboard', to: 'dashboard#index'

  # Public routes - accessible to everyone
  resources :items, only: [ :index, :show ]

  # Authenticated user routes
  authenticate :user do
    # User profile management
    resource :profile, controller: 'users', only: [ :show, :edit, :update ]
    end
    # Shopping cart functionality
    resource :cart, only: [ :show, :update ] do
      resources :cart_items, only: [ :create, :update, :destroy ]
    end

    # Order management
    resources :orders, only: [ :index, :show, :create ] do
      resources :order_items, only: [ :show ]
    end

    # User's purchase history
    resources :purchased_items, only: [ :index ]
  end

  # Admin routes for full CRUD operations
  authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      # Admin dashboard
      root 'dashboard#index'
      get 'dashboard', to: 'dashboard#index'

      # User management with admin actions
      resources :users do
        member do
          patch :toggle_admin
          patch :activate
          patch :deactivate
        end
      end


      resources :items do
        member do
          patch :toggle_featured     # Mark as featured item
          patch :toggle_availability
        end
        collection do
          get :featured             # List featured items
          get :out_of_stock        # List unavailable items
        end
      end

      # Cart management (view and modify user carts)
      resources :carts do
        resources :cart_items, except: [ :new, :edit ]
        member do
          delete :clear
        end
      end

      # Order management with status updates
      resources :orders do
        member do
          patch :mark_as_paid      # Update payment status
          patch :mark_as_shipped
          patch :mark_as_delivered
          patch :cancel
          patch :refund            # Process refund
        end
        resources :order_items, except: [ :new, :edit ]
        collection do
          get :pending
          get :shipped
          get :completed
        end
      end

      # Purchase history management
      resources :purchased_items, only: [ :index, :show, :destroy ] do
        collection do
          get :by_user
          get :by_item
          get :recent
        end
      end
    end
  end


  match '/404', to: 'errors#not_found', via: :all, as: :not_found
  match '/422', to: 'errors#unprocessable_entity', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all


  get "up" => "rails/health#show", as: :rails_health_check
  root "items#index"
end
