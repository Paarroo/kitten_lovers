Avo.configure do |config|
  config.root_path = '/admin'
  config.app_name = 'Kitten Lovers Admin'
  config.timezone = 'Paris'
  config.per_page = 24
  config.per_page_steps = [ 12, 24, 48, 72 ]
  config.locale = 'fr'

  # Auth
  config.current_user_method = :current_user

  # main_menu
  config.main_menu = lambda do
      section "Utilisateurs", icon: "user-group" do
        resource :users
      end

      section "Boutique", icon: "shopping-bag" do
        resource :items
        resource :orders
        resource :carts
      end

      section "Achats", icon: "credit-card" do
        resource :purchased_items
        resource :order_items
        resource :cart_items
      end
    end
end
