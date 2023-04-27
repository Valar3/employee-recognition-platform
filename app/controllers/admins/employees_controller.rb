module Admins
  class EmployeesController < AdminController
    def index
      @employees = Employee.all
    end

    def edit
      @employee = Employee.find(params[:id])
    end

    def edit_add_kudos_to_all
      @employee = Employee.all
      render 'admins/employees/update_add_kudos_to_all'
    end

    def update_add_kudos_to_all
      new_available_kudos = params[:number_of_available_kudos].to_i
      if new_available_kudos < 21
        Employee.transaction do
          Employee.find_each do |employee|
            employee.update(number_of_available_kudos: employee.number_of_available_kudos + new_available_kudos)
          end
          flash[:notice] = 'Successfully updated the number of kudos to all employees'
          redirect_to admin_root_path

        rescue ActiveRecord::RecordInvalid
          flash[:notice] = 'Invalid number of kudos, must be between 1 and 20.'
          render 'update_add_kudos_to_all'
        end
      else
        flash[:notice] = 'Invalid number of kudos, must be between 1 and 20.'
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

    def add_kudo_to_all_params
      params.fetch(:employee, {}).permit(:number_of_available_kudos)
    end
  end
end
