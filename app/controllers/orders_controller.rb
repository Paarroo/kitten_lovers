class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = if current_user.is_admin?
      Order.includes(:user, :order_items).order(created_at: :desc)
    else
      current_user.orders.includes(:order_items).order(created_at: :desc)
    end
  end

  def show
    @order = Order.includes(order_items: :item).find(params[:id])

    unless current_user.is_admin? || @order.user == current_user
      redirect_to orders_path, alert: "Accès refusé"
    end
  end

  def create
    cart = current_user.cart
    items_in_cart = cart.items

    if items_in_cart.empty?
      redirect_to items_path, alert: "Votre panier est vide."
      return
    end

    already_purchased_ids = current_user.purchased_items.pluck(:item_id)
    items_to_buy = items_in_cart.reject { |item| already_purchased_ids.include?(item.id) }

    if items_to_buy.empty?
      redirect_to cart_path, alert: "Vous detenez déjà toutes les photos de votre panier."
      return
    end

    total = items_to_buy.sum(&:price)

    order = Order.create!(
      user: current_user,
      total_price: total,
      status: "completed"
    )

    items_to_buy.each do |item|
      OrderItem.create!(order: order, item: item, unit_price: item.price)
      PurchasedItem.create!(user: current_user, item: item)
    end

    cart.cart_items.destroy_all

    redirect_to order_path(order), notice: "Commande passée avec succés!"
  end
end
