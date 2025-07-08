class ItemsController < ApplicationController
  def index
    # Only show items the current user hasn't purchased (if logged in)
    @items = if current_user
               Item.not_purchased_by(current_user)
             else
               Item.all
             end
  end

  def show
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
