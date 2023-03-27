module Admins
  class OrdersController < AdminController
    def index
      @employee = Employee.find(params[:employee_id])
      @orders = @employee.orders
    end
    def update
  #    @order = order.status
    #  order.status = 1
    end
  end
end
