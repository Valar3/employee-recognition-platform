module Admins
  class CategoriesController < AdminController
    def index
      render :index, locals: { categories: Category.all }
    end

    def show
      render :show, locals: { category: }
    end

    def new
      render :new, locals: { category: Category.new }
    end

    def edit
      render :edit, locals: { category: }
    end

    def create
      record = Category.new(category_params)

      if record.save
        redirect_to admins_categories_path(record), notice: 'Category was successfully created.'
      else
        render :new, locals: { category: record }
      end
    end

    def update
      if category.update(category_params)
          flash[:notice]='Category was successfully updated.'
        redirect_to admins_categories_path(category)
        render :edit, locals: { category: }
      end
    end

    def destroy
      @category = Category.find(params[:id])
      Category.transaction do
        @category.destroy!  
      end
      flash[:notice] = 'Category was deleted successfully'
      redirect_to admins_categories_path
    rescue StandardError
      flash[:notice] = 'Category deletion failed. You can not delete a category attached to a reward'
      redirect_to admins_categories_path
    end

    private

    def category
      @category ||= Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title)
    end
  end
end

