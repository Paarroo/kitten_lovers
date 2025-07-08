class OrderItemsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order_item = OrderItem.includes(:item, :order).find(params[:id])

    unless current_user.is_admin? || @order_item.order.user == current_user
      redirect_to root_path, alert: "Accès refusé"
    end
  end
end
