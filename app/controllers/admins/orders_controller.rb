module Admins
  class OrdersController < AdminController
    def index
      @employee = Employee.find(params[:employee_id])
      @orders = @employee.orders
    end
  end
end
