Rails.application.routes.draw do
your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Authentification utilisateur
  devise_for :users

  # Utilisateurs
  resources :users

  # Produits (anciennement photos)
  resources :items

  # Panier et contenu du panier
  resources :carts
  resources :cart_items

  # Commandes et contenus des commandes
  resources :orders, only: [:index, :show, :create]
  resources :order_items, only: [:show]

  # Historique des achats (si utile)
  resources :purchased_items, only: [:index]

  # Administration (back-office)
  namespace :admin do
    resources :items
    resources :users
    resources :orders
  end

  # Vérification de vie de l'app
  get "up" => "rails/health#show", as: :rails_health_check

  # Accueil
  root "items#index"
end
