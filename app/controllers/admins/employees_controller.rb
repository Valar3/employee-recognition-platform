module Admins
  class EmployeesController < AdminController
    def index
      @employees = Employee.all
    end

    def edit
      @employee = Employee.find(params[:id])
      if admin_signed_in?
        render 'admins/employees/edit'
      else
        flash[:alert] = 'You need to be loged as admin to perform this operation'
        redirect_to admins_employees_path
      end
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
      if @employee.update(params.require(:employee).permit(:email, :password, :number_of_available_kudos))
        flash[:notice] = 'Employee was edited successfully'
        redirect_to admins_employees_path
      else
        render 'admins/employees/edit'
      end
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:email, :password, :number_of_available_kudos)
  end
end
