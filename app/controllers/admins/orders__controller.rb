module Admins
  class OrdersController < AdminController

    def index
      @orders = Order.all
    end

    def update
      @order = Order.find(params[:id])

      if @order.update(order_params)
        @order.status == 1
        @order.save
      end
    end
  private
  def order_params
    params.permit(:status, :employee_id, :reward_id, :price )
  end
end
end
