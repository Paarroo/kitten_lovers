class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user, only: [ :show, :edit, :update, :delete_account ]

  def show
    @orders_count = @user.orders.count
    @purchased_items_count = @user.purchased_items.count
    @cart_items_count = @user.cart&.cart_items&.count || 0
    @recent_orders = @user.orders.includes(:order_items).order(created_at: :desc).limit(3)
    @recent_purchases = @user.purchased_items.includes(:item).order(created_at: :desc).limit(5)
  end

  def edit
    # @user is set by set_current_user callback
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profil mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def sign_out
    sign_out(current_user) if current_user
    redirect_to root_path, notice: 'Déconnecté avec succès.'
  end

  def delete_account
    if current_user == @user
      @user.destroy
      redirect_to root_path, notice: 'Compte supprimé avec succès.'
    else
      redirect_to root_path, alert: 'Vous n\'êtes pas autorisé à supprimer ce compte.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :email, :phone)
  end

  def set_current_user
    @user = current_user
  end
end
