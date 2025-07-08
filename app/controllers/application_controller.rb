class ApplicationController < ActionController::Base
 allow_browser versions: :modern

 before_action :authenticate_user!, except: [ :index, :show ], if: -> { !devise_controller? && !avo_controller? }
 before_action :configure_permitted_parameters, if: :devise_controller?

 protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :description ])
   devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :description ])
   devise_parameter_sanitizer.permit(:sign_in, keys: [ :email, :password, :remember_me ])
 end

 def after_sign_in_path_for(resource)
   if resource.admin?
     avo_root_path
   else
     root_path
   end
 end

 def after_sign_out_path_for(resource_or_scope)
   root_path
 end

 private

 def require_authentication
   unless user_signed_in?
     redirect_to new_user_session_path, alert: "Vous devez être connecté pour accéder à cette page."
   end
 end

 def require_admin
   unless current_user&.admin?
     redirect_to root_path, alert: "Accès refusé. Vous devez être administrateur pour accéder à cette page."
   end
 end

 def handle_unauthorized
   if user_signed_in?
     redirect_to root_path, alert: "Vous n'êtes pas autorisé à effectuer cette action."
   else
     redirect_to new_user_session_path, alert: "Vous devez être connecté pour accéder à cette page."
   end
 end
end
