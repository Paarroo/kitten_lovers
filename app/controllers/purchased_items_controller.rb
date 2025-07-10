class PurchasedItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchased_items = current_user.purchased_items.includes(:item).order(created_at: :desc)
  end

  def show
    @purchased_item = current_user.purchased_items.includes(:item).find(params[:id])
  end

  def create
    @item = Item.find(params[:item_id])

    if current_user.has_purchased?(@item)
      redirect_to @item, alert: "Vous avez déjà acheté cette photo."
      return
    end

    @purchased_item = PurchasedItem.new(
      user: current_user,
      item: @item,
      price_paid: @item.price
    )

    if @purchased_item.save
      current_user.cart.cart_items.where(item: @item).destroy_all
      redirect_to purchased_items_path, notice: "Photo achetée avec succès !"
    else
      redirect_to @item, alert: "Erreur lors de l'achat. Veuillez réessayer."
    end
  end
end
