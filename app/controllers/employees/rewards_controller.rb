module Employees
  class RewardsController < EmployeesController
    def index
      render :index, locals: { reward: Reward.all }
    end

    def show
      render :show, locals: { reward: Reward.find(params[:id]) }
    end

    private
    def copy
    price = Marshal.load(Marshal.dump(price))
    end
    def reward_params
      params.require(:reward).permit(:title, :description, :price)
    end
  end
end
