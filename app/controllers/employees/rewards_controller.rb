module Employees
  class RewardsController < EmployeesController
    def index
      online_rewards = Reward.includes(%i[image_attachment]).where('available_rewards > ? AND delivery_method = ?', 0,
                                                                   '0')
      post_rewards = Reward.includes(%i[image_attachment]).where(delivery_method: '1')

      all_rewards = online_rewards.or(post_rewards).paginate(page: params[:page], per_page: 8)

      render :index, locals: { reward: all_rewards }
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
