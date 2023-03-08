module Employees
  class KudosController < EmployeesController
    def index
      render :index, locals: { kudos: Kudo.includes(%i[giver receiver company_value]).all }
    end

    def new
      @kudo = Kudo.new
      if current_employee.number_of_available_kudos <= 0
        flash[:alert] = 'You have used all your kudos'
        redirect_to root_path
      else
        render 'employees/kudos/new'
      end
    end

    def edit
      render :edit, locals: { kudo: Kudo.find(params[:id]) }
    end

    def create
      @kudo = Kudo.new(kudo_params)
      @kudo.giver_id = current_employee.id
      Employee.transaction do
        @kudo.save!
        @current_employee.number_of_available_kudos -= 1
        @current_employee.save!
        Kudo.transaction do
          @kudo.receiver.number_of_earned_points += 10
          @kudo.receiver.save!
          flash[:notice] = 'Kudo was created successfully'
          redirect_to root_path
        end
      end
    rescue ActiveRecord::RecordInvalid
      render 'employees/kudos/new'
    end

    def update
      kudo = Kudo.find(params[:id])
      if kudo.update(kudo_params)
        flash[:notice] = 'Kudo was edited successfully'
        redirect_to root_path
      else
        render :edit, locals: { kudo: }
      end
    end

    def destroy
      @kudo = Kudo.find(params[:id])
      Kudo.transaction do
        @kudo.destroy!
        @kudo.receiver.number_of_earned_points -= 10
        @kudo.receiver.save!
        flash[:notice] = 'Kudo was deleted successfully'
        redirect_to root_path
      end
    rescue ActiveRecord::RecordInvalid
      flash[:notice] = 'Kudo deletion failed'
      redirect_to root_path
    end

    private

    def kudo_params
      params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id, :company_value_id)
    end
  end
end
