class Admin::UserManagementsController < InheritedResources::Base

  private

    def user_management_params
      params.require(:user_management).permit(:first_name, :last_name, :email, :phone, :status)
    end

end
