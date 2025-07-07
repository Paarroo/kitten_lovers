class Admin::SessionsController < Admin::ApplicationController
  # conexion_page user/ admin
  skip_before_action :ensure_admin!, only: [ :new, :create ]

  # form co,connexion
  def new
    # Si l'utilisateur est déjà connecté ET admin, on le redirige
    if user_signed_in? && current_user.admin?
      redirect_to admin_root_path
      return
    end
  end


  def create
    # recherche user by Devise
    user = User.find_for_database_authentication(email: params[:email])

    # verif pass && admin  right
    if user && user.valid_password?(params[:password])
      if user.admin?
        # con succes for admin
        sign_in(user)
        Rails.logger.info "Connexion admin réussie: #{user.email}"
        redirect_to admin_root_path, notice: "Bienvenue #{user.full_name} !"
      else
        # user valide but not admin
        Rails.logger.warn "Tentative d'accès admin non autorisée: #{user.email}"
        flash.now[:alert] = "Accès non autorisé. Seuls les administrateurs peuvent accéder à cette zone."
        render :new, status: :unprocessable_entity
      end
    else
      # email or passw incorrect
      Rails.logger.warn "Tentative de connexion admin échouée: #{params[:email]}"
      flash.now[:alert] = "Email ou mot de passe incorrect."
      render :new, status: :unprocessable_entity
    end
  end

  # logout
  def destroy
    Rails.logger.info "Déconnexion admin: #{current_user.email}"
    sign_out(current_user)
    redirect_to root_path, notice: "Déconnexion réussie."
  end
end
