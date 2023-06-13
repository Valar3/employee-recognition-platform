module Employees
  class CategoriesController < EmployeesController
    def show
      render :show, locals: { category: Category.find(params[:id]) }
    end
  end
end
