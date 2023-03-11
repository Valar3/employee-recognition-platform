module Employees
  module Rewards
    class OrdersController < EmployeesController
      before_action :set_reward
      def new
        @order= Order.new
      end
      def create
        @order = @reward.orders.new(employee: current_employee)
        if @order.save
          flash[:notice] = 'Reward was successfully bought'
          redirect_to employees_rewards_path
        else
          render :new
        end
      end
        private

      def set_reward
        @reward = Reward.find(params[:reward_id])
      end
    end
  end
end
