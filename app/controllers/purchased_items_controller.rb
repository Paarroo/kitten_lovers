class PurchasedItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchased_items = current_user.purchased_items.includes(:item).order(created_at: :desc)
  end

  def show
    @purchased_item = current_user.purchased_items.includes(:item).find(params[:id])
  end

  def create
    @purchased_item = current_user.purchased_items.new(purchased_item_params)

    if @purchased_item.save
      redirect_to @purchased_item, notice: 'Votre achat à bien été effectué'
    else
      render :new
    end
  end

  private

  def purchased_item_params
    params.require(:purchased_item).permit(:item_id)
  end
end
