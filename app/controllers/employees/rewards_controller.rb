module Employees
  class RewardsController < EmployeesController
    def index
      render :index,
             locals: { reward: Reward.includes(%i[image_attachment]).paginate(page: params[:page], per_page: 3) }
    end

    def show
      render :show, locals: { reward: Reward.find(params[:id]) }
    end

    private

    def reward_params
      params.require(:reward).permit(:delivery_method, :title, :description, :price, :category_id, :image,
                                     :available_rewards, online_codes_attributes: %i[code used id _destroy])
    end
  end
end
