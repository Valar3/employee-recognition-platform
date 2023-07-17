module Employees
  class RewardsController < EmployeesController
    def index
      render :index, locals: { reward: Reward.paginate(page: params[:page], per_page: 3) }
    end
    def delivery
      render :delivery, locals: { reward: Reward.find(params[:id]) }
    end

    def show
      render :show, locals: { reward: Reward.find(params[:id]) }
    end
  end
end
