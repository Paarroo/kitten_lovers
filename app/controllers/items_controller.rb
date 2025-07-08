class ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def index
    if current_user
      purchased_ids = current_user.purchased_items.pluck(:item_id)
      @items = Item.where.not(id: purchased_ids)
    else
      @items = Item.all
    end
  end

  def show
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
