module Employees
  class RewardsController < EmployeesController
    def index
      render :index, locals: { reward: Reward.paginate(page: params[:page], per_page: 3) }
    end

    def create
      @reward = Reward.new(reward_params)
      @reward.address.first.employee_id = current_employee.id
      if @reward.save
        redirect_to employees_rewards_path
      else
        render 'rewards/order'
      end
    end

    def delivery
      @employee = current_employee
      @reward = Reward.find(params[:id])
      binding.pry
      
      if @reward.update(reward_params)
        if @reward.post_delivery?
          @employee.build_address unless @employee.address.present?

        end
        #redirect_to employees_update_path
      else
        render 'employees/rewards/delivery'
      end
    end

    def show
      render :show, locals: { reward: Reward.find(params[:id]) }
    end

    private

    def reward_params
      params.require(:reward).permit(
        :title, :description, :price, :category_id, :image, :delivery_method,
        address_attributes: [:street, :postcode, :city]
      )
    end

    def address_params
      params.require(:address).permit(:street, :postcode, :city)
    end
        #redirect_to employees_update_path
      #else
      #  flash[:alert] = 'You do not have enough points'
       # redirect_to employees_rewards_path
      #end

      #  @employee = current_employee
     #   @employee.build_address unless @employee.address.present?    end






  end
end
