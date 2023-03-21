module Admins
  module Employees
    class OrdersController < AdminController

      def index
        render :index, locals: { orders: Order.all }
      end

      def show
        render :show, locals: { order: Order.find(params[:id])}
      end

    end
  end
end
