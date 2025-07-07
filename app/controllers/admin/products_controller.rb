class Admin::ProductsController < InheritedResources::Base

  private

    def product_params
      params.require(:product).permit(:name, :description, :price, :category, :stock)
    end

end
