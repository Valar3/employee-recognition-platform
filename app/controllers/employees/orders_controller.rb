module Employees
  class OrdersController < EmployeesController
    def index
      orders = case params[:status]
               when 'delivered'
                 Order.delivered
               when 'non_delivered'
                 Order.non_delivered
               else
                 Order.all
               end
      render :index, locals: { orders: }
    end

    def create
      reward = Reward.find(params[:reward_id])
      order = reward.orders.new(employee: current_employee)
      Order.transaction do
        order.price = order.reward.price
        order.save!
        current_employee.number_of_earned_points -= reward.price
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
  end
end
