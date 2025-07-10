class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [ :show, :edit, :update, :delete_account ]


  def show
    @orders_count = @user.orders.count
    @purchased_items_count = @user.purchased_items.count
    @cart_items_count = @user.cart&.cart_items&.count || 0
    @recent_orders = @user.orders.includes(:order_items).order(created_at: :desc).limit(3)
    @recent_purchases = @user.purchased_items.includes(:item).order(created_at: :desc).limit(5)
  end

  def edit
    # @user define by ensure_correct_user (user security)
    # Do edition formulaire
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profil mis à jour avec succès."
    else
      render :edit
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
    params.require(:user).permit(:first_name, :last_name, :description)
  end

  def ensure_correct_user
    unless params[:id].present?
      redirect_to root_path, alert: "L'ID de l'utilisateur est manquant."
      return
    end

    @user = User.find(params[:id])

    unless @user == current_user
      redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à cette page."
    end
  end
end
