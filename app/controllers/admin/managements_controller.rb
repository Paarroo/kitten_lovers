class Admin::ManagementsController < InheritedResources::Base

  private

    def management_params
      params.require(:management).permit(:name, :role, :phone, :email)
    end

end
