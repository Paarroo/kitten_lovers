class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart
    @item = Item.find(params[:item_id])
    @cart_item = @cart.cart_items.new(item: @item)

    respond_to do |format|
      if @cart_item.save
        format.turbo_stream
        format.html do
          if params[:redirect_to_cart]
            redirect_to cart_path, notice: "Ajouté au panier."
          else
            redirect_back fallback_location: items_path, notice: "Ajouté au panier."
          end
        end
      else
        format.turbo_stream
        format.html { redirect_back fallback_location: items_path, alert: "Déjà dans le panier." }
      end
    end
  end


  def destroy
    @cart_item = current_user.cart.cart_items.find_by(id: params[:id])

    respond_to do |format|
      if @cart_item&.destroy
        format.turbo_stream
        format.html { redirect_back fallback_location: items_path, notice: "Retiré du panier." }
      else
        format.turbo_stream
        format.html { redirect_back fallback_location: items_path, alert: "Erreur." }
      end
    end
  end
end
