module Admins
  class CompanyValuesController < AdminController
    def index
      @company_values = CompanyValue.all
    end

    def edit
      @company_value = CompanyValue.find(params[:id])
    end

    def destroy
      @company_value = CompanyValue.find(params[:id])
      flash[:notice] = if @company_value.destroy
                         'Company value was deleted successfully'
                       else
                         'Company value deletion failed'
                       end
      redirect_to admins_company_values_path
    end

    def update
      @company_value = CompanyValue.find(params[:id])
      if @company_value.update(company_value_params)
        flash[:notice] = 'Company value was edited successfully'
        redirect_to admins_company_values_path
      else
        render 'admins/company_values/edit'
      end
    end

    def new
      @company_value = CompanyValue.new
    end

    def create
      @company_value = CompanyValue.new(company_value_params)
      if @company_value.save
        flash[:notice] = 'Company value was created successfully'
        redirect_to admins_company_values_path
      else
        render 'admins/company_values/new'
      end
    end

    private

    def company_value_params
      params.require(:company_value).permit(:title)
    end
  end
end
