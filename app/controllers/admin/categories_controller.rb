class Admin::CategoriesController < InheritedResources::Base

  private

    def category_params
      params.require(:category).permit(:name, :description, :active)
    end

end
