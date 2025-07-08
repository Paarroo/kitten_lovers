class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart
    @item = Item.find(params[:item_id])
    
    @cart_item = @cart.cart_items.new(item: @item)

    if @cart_item.save
      redirect_to cart_path, notice: "Article ajouté à votre panier."
    else
      redirect_to items_path, alert: "Cet article est déjà dans votre panier."
    end
  end

  def destroy
    @cart_item = current_user.cart.cart_items.find_by(id: params[:id])

    if @cart_item
      @cart_item.destroy
      redirect_to cart_path, notice: "Article retiré du panier."
    else
      redirect_to cart_path, alert: "Action non autorisée."
    end
end