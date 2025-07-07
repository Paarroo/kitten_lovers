Rails.application.routes.draw do
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
  resources :orders
  resources :order_items

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
