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
      redirect_to orders_path, alert: "Access denied"
    end
  end

  # Stripe checkout session creation
  def checkout
    cart = current_user.cart
    items = cart.items

    if items.empty?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    already_purchased_ids = current_user.purchased_items.pluck(:item_id)
    items_to_buy = items.reject { |item| already_purchased_ids.include?(item.id) }

    if items_to_buy.empty?
      redirect_to cart_path, alert: "You already own all items in your cart."
      return
    end

    # Calculate total in cents for Stripe
    total_amount = (items_to_buy.sum(&:price) * 100).to_i

    # Create Stripe Checkout Session
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: items_to_buy.map do |item|
        {
          price_data: {
            currency: 'eur',
            product_data: { name: item.title },
            unit_amount: (item.price * 100).to_i
          },
          quantity: 1
        }
      end,
      mode: 'payment',
      success_url: order_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: order_cancel_url
    )

    redirect_to session.url, allow_other_host: true
  end

  # Stripe returns here after successful payment
def success
  session = Stripe::Checkout::Session.retrieve(params[:session_id])

  # 🔒 Check if order already exists for this session
  existing_order = Order.find_by(stripe_session_id: session.id)
  if existing_order
    redirect_to order_path(existing_order), notice: "Payment already confirmed."
    return
  end

  if session.payment_status == "paid"
    cart = current_user.cart
    items_to_buy = cart.items.reject { |item| current_user.purchased_items.exists?(item: item) }
    total = items_to_buy.sum(&:price)

    # 🧾 Create new order only if not already done
    order = Order.create!(
      user: current_user,
      total_price: total,
      status: "completed",
      stripe_session_id: session.id
    )

    items_to_buy.each do |item|
      OrderItem.create!(order: order, item: item, unit_price: item.price)
      PurchasedItem.create!(user: current_user, item: item)
    end

    cart.cart_items.destroy_all

    redirect_to order_path(order), notice: "Payment successful! Your order has been confirmed."
  else
    redirect_to cart_path, alert: "Payment was not successful."
  end
 end

end
