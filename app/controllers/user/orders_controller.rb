class User::OrdersController < InheritedResources::Base

  private

    def order_params
      params.require(:order).permit(:number, :total, :status)
    end

end
