module Admins
  module Employees
    class OrdersController < AdminController
      def index
        @orders = Order.includes([:employee]).all.order(status: :asc)
        respond_to do |format|
          format.html
          format.csv do
            send_data Order.to_csv, filename: Time.zone.today.to_s, content_type: 'text/csv'
          end
        end
      end

      def update
        @order = Order.find(params[:id])
        if @order.update(status: 1)
          OrderMailer.with(order: @order).confirmation_email.deliver_later
          flash[:notice] = 'Order was successfully delivered'
        else
          flash[:notice] = 'Order delivery failed'
        end
        redirect_to admins_employees_orders_path
      end
    end
  end
end
