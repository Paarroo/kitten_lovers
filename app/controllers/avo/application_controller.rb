class Avo::ApplicationController < ::ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  private

  def authorize_admin!
    redirect_to root_path, alert: "Accès refusé. Vous devez être administrateur." unless current_user&.admin?
  end
end
