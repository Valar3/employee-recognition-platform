module Admins
  class Orders2Controller < AdminController
    def index
      @employee = Employee.find(params[:employee_id])
      @orders = @employee.orders
    end
  end
end
