class PurchasedItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchased_items = current_user.purchased_items.includes(:item).order(created_at: :desc)
  end

  def show
    @purchased_item = current_user.purchased_items.includes(:item).find(params[:id])
  end
end
