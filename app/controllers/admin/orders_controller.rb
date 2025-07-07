class Admin::OrdersController < InheritedResources::Base

  private

    def order_params
      params.require(:order).permit(:number, :total, :status, :user_id)
    end

end
