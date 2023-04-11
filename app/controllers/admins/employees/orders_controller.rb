module Admins
  module Employees
    class OrdersController < AdminController
      def index
        @orders = Order.all.order(status: :asc)
      end

      def update
        @order = Order.find(params[:id])
        flash[:notice] = if @order.update(status: 1)
                           OrderMailer.with(order: @order).confirmation_email.deliver_now
                           'Order was successfully delivered'
                         else
                           'Order delivery failed'
                         end
        redirect_to admins_employees_orders_path
      end
    end
  end
end
