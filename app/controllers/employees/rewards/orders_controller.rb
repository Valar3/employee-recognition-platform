module Employees
  module Rewards
    class OrdersController < EmployeesController
      def create
        reward = Reward.find(params[:reward_id])
        order = reward.orders.new(employee: current_employee)
        Order.transaction do
          order.save!
          current_employee.number_of_earned_points -= reward.price
          @reward.price2 = Marshal.load(Marshal.dump(@reward.price))
          Employee.transaction do
            current_employee.save!
            flash[:notice] = 'Reward was successfully bought'
            redirect_to employees_rewards_path
          end
        end
      rescue ActiveRecord::RecordInvalid
        flash[:alert] = 'You do not have enough points'
        redirect_to employees_rewards_path
      end
      def index
        render :index, locals: {orders: Order.all}
       # order.reward.price_two = Marshal.load(Marshal.dump(order.reward.price))
      end
    end
  end
end
