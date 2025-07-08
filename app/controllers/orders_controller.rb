class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    @order = current_user.orders.build(order_params)
  end

  private

  def order_params
    params.require(:order).permit(:total_price, :status)
  end
end
