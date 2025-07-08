class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
     @cart_items = @cart.cart_items.includes(:item)
  end

  def clear
  current_user.cart.cart_items.destroy_all
  redirect_to cart_path, notice: "Panier vidé."
end

end
