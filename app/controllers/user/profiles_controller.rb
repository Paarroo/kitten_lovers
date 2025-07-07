class User::ProfilesController < InheritedResources::Base

  private

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :phone, :bio)
    end

end
