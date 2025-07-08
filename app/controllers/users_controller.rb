class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [ :show, :edit, :update ]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profil mis à jour avec succès."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description)
  end

  def ensure_correct_user
    @user = current_user
  end
end
