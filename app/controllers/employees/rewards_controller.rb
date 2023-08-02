module Employees
  class RewardsController < EmployeesController
    def index
      render :index, locals: { reward: Reward.includes(%i[image_attachment  ]).paginate(page: params[:page], per_page: 3) }
    end

    def edit
      render :edit, locals: { reward: Reward.find(params[:id]) }
    end

    def update
      reward = Reward.find(params[:id])
      if reward.update(reward_params)
        if reward.post_delivery?
          flash[:notice] = 'You have chosen Post delivery as your delivery method'
          redirect_to new_with_reward_employees_orders_path(reward_id: reward.id)
        elsif reward.online?
          flash[:notice] = 'You have chosen Online as your delivery method'
          redirect_to employees_rewards_path
        end
      else
        flash[:alert] = 'Something went wrong'
        render :edit, locals: { reward: }

      end
    end

    def show
      render :show, locals: { reward: Reward.find(params[:id]) }
    end

    private

    def reward_params
      params.require(:reward).permit(:delivery_method, :title, :description, :price, :category_id, :image)
    end
  end
end
