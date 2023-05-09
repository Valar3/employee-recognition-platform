module Admins
  class CategoriesController < AdminController
    def index
      render :index, locals: { categories: Category.all }
    end

    def edit
      render :edit, locals: { category: Category.find(params[:id]) }
    end

    def destroy
      @category = Category.find(params[:id])
       if @category.destroy && @reward.categories.empty?
        flash[:notice] = 'Category was deleted successfully'
           else
                    flash[:notice] ='Category deletion failed'
                       end
      redirect_to admins_categories_path
    end

    def update
      category = Category.find(params[:id])
      if category.update(category_params)
        flash[:notice] = 'Category was edited successfully'
        redirect_to admins_categories_path
      else
        render :edit, locals: { category: }
      end
    end

    def new
      render :new, locals: { category: Category.new }
    end

    def create
      category = Category.new(category_params)
      if category.save
        flash[:notice] = 'Category was created successfully'
        redirect_to admins_categories_path
      else
        render :new, locals: { category: }
      end
    end

    private

    def category_params
      params.require(:category).permit(:title)
    end
  end
end
