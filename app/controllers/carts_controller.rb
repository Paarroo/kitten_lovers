class CartsController < ApplicationController

  def show
    @cart = User.first.cart
  end
end
