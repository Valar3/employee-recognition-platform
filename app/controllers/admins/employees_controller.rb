module Admins
  class EmployeesController < AdminController
    def index
      @employees = Employee.all
    end

    def edit
      @employee = Employee.find(params[:id])
    end


    def add_kudos_to_all
      @employee = Employee.all.find_each do |employee|
      if employee.update(employee_params_2)   && employee.number_of_available_kudos <= 20
        flash[:notice] = 'Successfully updated the numer of kudos to all employees'
       # redirect_to 'admins/employees'
      else
        flash[:notice] = 'The numer of kudos you want to add is too high'
      end
        #render 'admins/employees/add_kudos_to_all'
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

    def employee_params_2
      params.fetch(:employee, {}).permit(:number_of_available_kudos)
    end
  end
end
