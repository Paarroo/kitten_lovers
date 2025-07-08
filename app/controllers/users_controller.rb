class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [ :show, :edit, :update, :delete_account ]

  def show
    # Display the user's profile
  end

  def edit
    # Render the edit profile form
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profil mis à jour avec succès."
    else
      render :edit
    end
  end

  def sign_out
    # Clear the session to log out the user
    if session['warden.user.user.key']
      session.clear
      redirect_to root_path, notice: 'Déconnecté avec succès.'
    else
      redirect_to root_path, alert: 'Vous n\'êtes pas connecté.'
    end
  end

  def delete_account
    # Delete the user account
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
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à cette page."
    end
  end
end
