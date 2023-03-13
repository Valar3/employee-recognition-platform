module Employees
  module Rewards
    class OrdersController < EmployeesController
      before_action :set_reward
      def new
        @order = Order.new
      end

      def create
        # flash[:alert]= 'You do not have enough points for that reward'
        @order = @reward.orders.new(employee: current_employee)
        if @order.save
          current_employee.number_of_earned_points -= @reward.price
          @current_employee.save
          flash[:notice] = 'Reward was successfully bought'
        else
          flash[:alert] = 'You do not have enough points'
        end
        redirect_to employees_rewards_path
      end

      private

      def set_reward
        @reward = Reward.find(params[:reward_id])
      end
    end
  end
end
