module Admins
  class CompanyValuesController < AdminController
    def index
      @company_value = CompanyValue.all
    end
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    def edit
      @company_value = Company_Value.find(params[:id])
    end

    def destroy
      @company_value = Company_value.find(params[:id])
      flash[:notice] = if @company_value.destroy
                         'Company value was deleted successfully'
                       else
                         'Company value deletion failed'
                       end
      redirect_to admins_company_values_path
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
