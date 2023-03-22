module Admins
  module Employees
    class OrdersController < AdminController

      def index
        @employee = employee.orders
      end

      def show
        employee = Employee.find(params[:id])
      end
    end
  end
end
