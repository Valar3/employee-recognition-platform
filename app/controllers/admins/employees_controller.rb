module Admins
  class EmployeesController < AdminController
    def index
      @employees = Employee.all
    end

    def edit
      @employee = Employee.find(params[:id])
    end

    def destroy
      @employee = Employee.find(params[:id])
      flash[:notice] = if @employee.destroy
                         'Employee account was deleted successfully'
                       else
                         'Employee account deletion failed'
                       end
      redirect_to admins_employees_path
    end

    def update
      @employee = Employee.find(params[:id])
      if @employee.update(employee_params)
        flash[:notice] = 'Employee was edited successfully'
        redirect_to admins_employees_path
      else
        render 'admins/employees/edit'
      end
    end

    private

    def employee_params
      params.require(:employee).permit(:email, :password, :number_of_available_kudos)
    end
  end
end
