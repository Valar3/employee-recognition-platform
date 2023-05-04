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
      @kudo = Kudo.find(params[:id])
      return if Time.zone.now - @kudo.created_at < 5.minutes

      redirect_to root_path
      flash[:notice] = 'Time for editing has passed'
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
      authorize kudo
      if kudo.update(kudo_params)
        flash[:notice] = 'Kudo was edited successfully'
        redirect_to root_path
      elsif Time.zone.now - kudo.created_at > 5.minutes
        flash[:notice] = 'The time for edition and deletion of Kudo has passed'
        rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
        render :edit, locals: { kudo: }
      end
    end

    def destroy
      @kudo = Kudo.find(params[:id])
      authorize @kudo
      Kudo.transaction do
        @kudo.destroy!
        @kudo.receiver.number_of_earned_points -= 10
        @kudo.receiver.save!
        flash[:notice] = 'Kudo was deleted successfully'
        redirect_to root_path
      end
    end
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def kudo_params
      params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id, :company_value_id)
    end
  end
end
