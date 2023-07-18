module Employees
  class RewardsController < EmployeesController
    def index
      render :index, locals: { reward: Reward.paginate(page: params[:page], per_page: 3) }
    end

    def delivery
      render :delivery, locals: { reward: Reward.find(params[:id]) }
    end

    def delivery_address
      @reward = Reward.find(params[:id])
      if @reward.post_delivery? && @reward.update(reward_params)
        redirect_to employees_rewards_order_address_path(reward)
      end
    end
    
    def show
      render :show, locals: { reward: Reward.find(params[:id]) }
    end

    private
    def reward_params
      params.require(:reward).permit(:title, :description, :price, :category_id, :image, :delivery_method, :city, :street, :postal_code )
    end
  end
end
