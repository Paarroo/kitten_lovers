class CartController < ApplicationController

  def show
    @cart = current_user.cart
  end
end
